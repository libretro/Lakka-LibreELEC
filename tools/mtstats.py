#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

import sys, os, codecs, datetime, time
import copy

ALL_STATUSES = ["ACTIVE", "FAILED", "GETPKG", "IDLE", "LOCKED", "MUTEX", "MUTEX/W", "STALLED", "UNLOCK"]
BUSY_STATUSES = ["ACTIVE", "MUTEX", "GETPKG"]
STALLED_STATUSES = ["STALLED", "MUTEX/W"]

EPOCH = datetime.datetime(1970, 1, 1)

MAXSLOTS = None

class HistoryEvent:
    def __init__(self, event):
        # squash spaces, then split by space
        items = ' '.join(event.replace("\n", "").split()).split(" ")

        self.datetime = "%s %s" % (items[0], items[1][:-4])
        (self.slot, self.seq) = items[3][1:-1].split("/")
        self.status = items[4]
        self.task = items[5] if len(items) > 5 else ""
        self.task = items[5] if len(items) > 5 else ""
        self.package = items[6] if len(items) > 6 else ""
        self.msg = ' '.join(items[7:]) if len(items) > 7 else ""
        self.secs = None

    def __repr__(self):
        return "%s; %s; %s; %s; %s; %s; %s;" % (self.datetime, self.slot, self.seq, self.status, self.task, self.package, self.msg)

    def get_time_secs(self):
        if self.secs == None:
            self.secs = (datetime.datetime.strptime(self.datetime, "%Y-%m-%d %H:%M:%S.%f") - EPOCH).total_seconds()
        return self.secs

    def isConfig(self):
        return (self.task == "config")

    def getConfig(self, item, default=None):
        if self.isConfig():
            pairs = self.msg.split(";")
            for pair in pairs:
                (key, value) = pair.split("=")
                if key == item:
                    return(value)
        return default

def calc_pct(a, b):
  if b > 0.0:
      return (a / b) * 100
  else:
      return 0.0

def pct_brackets(pct):
    spct = "%04.1f" % pct
    if float(spct) >= 100.0:
        return "( %s%%)" % spct[:-2]
    else:
        return "(%s%%)" % spct

def secs_to_hms(seconds, blankzero=False):
    hours = "%02d" % int(seconds / 3600)
    mins = "%02d" % int(seconds / 60 % 60)
    secs = "%06.3f" % (seconds % 60)
    if blankzero and hours == "00":
      hours = "  "
      if mins == "00":
        mins = "  "
    return "%2s:%2s:%s" % (hours, mins, secs)

def get_busy_total(slot):
    return summary[slot]["busy"]["total"]

def get_concurrent_val(concurrent):
    return concurrency[concurrent]["total"]

#---------------------------

events = []
for event in sys.stdin: events.append(HistoryEvent(event))

if len(events) > 0 and events[0].isConfig():
    MAXSLOTS = events[0].getConfig("slots")
    del events[0]

if len(events) == 0:
    sys.exit(1)

started = events[0].get_time_secs()
ended = events[-1].get_time_secs()
now = time.time()

last_active = ended
incomplete = False

concurrency = {}
active = peak = 0

slotn = {}
if MAXSLOTS:
    for s in range(1, int(MAXSLOTS) + 1):
        slotn["%0*d" % (len(events[0].slot),s)] = 0
else:
    for event in events:
        slotn[event.slot] = 0

# Acumulate information in this hash - meh
data = {"previous_status": None, "isactive": False, "statuses": {}}
for status in ALL_STATUSES:
    data["statuses"][status] = {"enabled": False, "count": 0, "start": 0.0, "total": 0.0}
data["statuses"]["IDLE"]["start"] = started

# For each slot allocate data storage
slots = {}
for slot in slotn:
    slots[slot] = copy.deepcopy(data)

# Process all events, accumulating counts and elapsed time for each status by slot
for event in events:
    slot = slots[event.slot]

    # Record accumulated time for the previous event
    previous = slot["previous_status"]

    if previous and slot["statuses"][previous]["enabled"] == True:
        prev_status = slot["statuses"][previous]
        prev_status["enabled"] = False
        prev_status["total"] += (event.get_time_secs() - prev_status["start"])

    # Determine max concurrency
    if event.status in BUSY_STATUSES:
        if previous == None or previous not in BUSY_STATUSES:
            active += 1
            concurrent = concurrency.get(active, {"start": 0.0, "total": 0.0})
            concurrent["start"] = event.get_time_secs()
            concurrency[active] = concurrent
            if active > peak:
                peak = active
    elif previous in BUSY_STATUSES:
        concurrency[active]["total"] += (event.get_time_secs() - concurrency[active]["start"])
        active -= 1

    # Record details for the new event
    this_status = slot["statuses"][event.status]
    this_status["enabled"] = True
    this_status["count"] += 1
    this_status["start"] = event.get_time_secs()
    slot["previous_status"] = event.status

# If any slots remain active then either the build has failed or the build is
# ongoing in which case "close" the active slots with the current time.
# For IDLE states, "close" the event with the elapsed time to the last known event.
for slot in slots:
    for status in slots[slot]["statuses"]:
        if status == "IDLE":
            if slots[slot]["statuses"]["FAILED"]["enabled"] == True:
                slots[slot]["statuses"][status]["total"] += (last_active - slots[slot]["statuses"]["FAILED"]["start"])
            else:
                slots[slot]["statuses"][status]["total"] += (last_active - slots[slot]["statuses"][status]["start"])
        elif slots[slot]["statuses"][status]["enabled"] == True:
            if status != "FAILED":
                incomplete = True
                slots[slot]["isactive"] = True
                slots[slot]["statuses"][status]["total"] += (now - slots[slot]["statuses"][status]["start"])
                ended = now

# Summarise slot data by various criteria
summary = {}
cumulative_count = cumulative_total = 0
for slot in slots:
    acount = atotal = 0
    scount = stotal = 0
    ccount = ctotal = 0

    for status in BUSY_STATUSES:
        if status in slots[slot]["statuses"]:
            acount += slots[slot]["statuses"][status]["count"]
            atotal += slots[slot]["statuses"][status]["total"]

    for status in STALLED_STATUSES:
        if status in slots[slot]["statuses"]:
            scount += slots[slot]["statuses"][status]["count"]
            stotal += slots[slot]["statuses"][status]["total"]

    for status in slots[slot]["statuses"]:
        ccount += slots[slot]["statuses"][status]["count"]
        ctotal += slots[slot]["statuses"][status]["total"]
    cumulative_count += ccount
    cumulative_total += ctotal

    summary[slot] = {"busy":    {"count": acount, "total": atotal},
                     "stalled": {"count": scount, "total": stotal},
                     "cumulative": {"count": ccount, "total": ctotal}}

# Accumulate stalled stats
stalled_count = stalled_total = 0
for slot in summary:
    stalled_count += summary[slot]["stalled"]["count"]
    stalled_total += summary[slot]["stalled"]["total"]

elapsed = (ended - started)

print("Total Build Time: %s (wall clock)" % secs_to_hms(elapsed, blankzero=False))
print("Accum Build Time: %s (%d slots)\n" % (secs_to_hms(cumulative_total, blankzero=False), len(slots)))

if incomplete:
    print("*** WARNING: active slots detected - build may be in progress/incomplete ***\n")

cum_total = 0.0
print("Breakdown by status (all slots):\n")
print("  Status   Usage         ( Pct )  Count  State")
for status in sorted(ALL_STATUSES):
    total = 0
    count = 0
    for slot in slots:
        if status in slots[slot]["statuses"]:
            count += slots[slot]["statuses"][status]["count"]
            total += slots[slot]["statuses"][status]["total"]

    pct = calc_pct(total, cumulative_total)
    cum_total += total

    if status in BUSY_STATUSES:
        stype = "busy"
    elif status in STALLED_STATUSES:
        stype = "stall"
    else:
        stype = ""
    print("  %-7s  %12s  %-7s  %-5d  %-5s" % (status, secs_to_hms(total, blankzero=True), pct_brackets(pct),  count, stype))
print("  -------------------------------------")
print("  %-7s  %12s  %-7s  %-5d" % ("TOTAL", secs_to_hms(cumulative_total, blankzero=True), \
       pct_brackets(calc_pct(cum_total, cumulative_total)), cumulative_count))
print("")

print("Peak concurrency: %d out of %d slots\n" % (peak, len(slots)))

print("%d job slots were held in a \"stall\" state for %s\n" % (stalled_count, secs_to_hms(stalled_total)))

print('Slot usage (time in a "busy" state):     | Concurrency breakdown ("busy"):')
print("                                         |")
print("#Rank  Slot  Usage        ( Pct )        | # of Slots  Usage        ( Pct )")

lines = []

busy_total = 0
for rank, slot in enumerate(sorted(summary, key=get_busy_total, reverse=True)):
    pct = calc_pct(summary[slot]["busy"]["total"], cumulative_total)
    state = "active" if slots[slot]["isactive"] == True else " "
    stime = secs_to_hms(summary[slot]["busy"]["total"], blankzero=True)
    busy_total += summary[slot]["busy"]["total"]
    lines.append("%s   %s %-7s %6s |" % (slot, stime, pct_brackets(pct), state))

concurrent_total = 0
for rank, concurrentn in enumerate(sorted(concurrency, key=get_concurrent_val, reverse=True)):
    concurrent = concurrency[concurrentn]
    pct = calc_pct(concurrent["total"], cumulative_total)
    stime = secs_to_hms(concurrent["total"], blankzero=True)
    concurrent_total += concurrent["total"]
    lines[rank] += "     %02d      %s %-7s" % (concurrentn, stime, pct_brackets(pct))

for rank, line in enumerate(lines):
    print(" #%02d    %s" % (rank + 1, line))

print("-----------------------------------------+---------------------------------")
print(" TOTALS      %s %-7s                      %s %-7s" %
      (secs_to_hms(busy_total, blankzero=True), pct_brackets(calc_pct(busy_total, cumulative_total)),
       secs_to_hms(concurrent_total, blankzero=True), pct_brackets(calc_pct(concurrent_total, cumulative_total))))
