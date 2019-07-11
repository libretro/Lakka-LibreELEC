#!/usr/bin/env python
# -*- coding: utf-8 -*-

# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

import sys, os, codecs, datetime, time

EPOCH = datetime.datetime(1970, 1, 1)

class HistoryEvent:
    def __init__(self, event):
        # squash spaces, then split by space
        items = ' '.join(event.replace("\n", "").split()).split(" ")

        self.datetime = "%s %s" % (items[0], items[1][:-4])
        (self.slot, self.seq) = items[3][1:-1].split("/")
        self.status = items[4]
        self.task = items[5] if len(items) > 5 else ""
        self.secs = None

    def __repr__(self):
        return "%s; %s; %s; %s; %s" % (self.datetime, self.slot, self.seq, self.status, self.task)

    def get_time_secs(self):
        if self.secs == None:
            self.secs = (datetime.datetime.strptime(self.datetime, "%Y-%m-%d %H:%M:%S.%f") - EPOCH).total_seconds()
        return self.secs

def secs_to_hms(seconds, blankzero=False):
    hours = "%02d" % int(seconds / 3600)
    mins = "%02d" % int(seconds / 60 % 60)
    secs = "%06.3f" % (seconds % 60)
    if blankzero and hours == "00":
      hours = "  "
      if mins == "00":
        mins = "  "
    return "%2s:%2s:%s" % (hours, mins, secs)

def get_slot_val(slot):
    return slots[slot]["total"]

def get_concurrent_val(concurrent):
    return concurrency[concurrent]["total"]

#---------------------------

events = []
for event in sys.stdin: events.append(HistoryEvent(event))

if len(events) == 0:
    sys.exit(1)

started = events[0].get_time_secs()
ended = events[-1].get_time_secs()
now = time.time()

slots = {}
concurrency = {}
active = peak = 0
for event in events:
    slot = slots.get(event.slot, {"active": False,
                                  "start": 0.0,
                                  "total": 0.0})

    if event.status in ["ACTIVE", "MUTEX", "GETPKG"]:
        if slot["active"] == False:
            active += 1
            concurrent = concurrency.get(active, {"start": 0.0, "total": 0.0})
            concurrent["start"] = event.get_time_secs()
            concurrency[active] = concurrent

            slot["active"] = True
            slot["start"] = event.get_time_secs()
            slots[event.slot] = slot

            if active > peak:
                peak = active

    elif slot["active"] == True:
        concurrency[active]["total"] += (event.get_time_secs() - concurrency[active]["start"])
        active -= 1
        slot["active"] = False
        slot["total"] += (event.get_time_secs() - slot["start"])
        slots[event.slot] = slot

# If any slots remain active, either the build failed or the build is ongoing, in
# which case "close" the active slots with the current time.
for slotn in slots:
    slot = slots[slotn]
    if slot["active"] == True:
        ended = now
        slot["total"] += (now - slot["start"])

elapsed = (ended - started)

print("Total Build Time: %s\n" % secs_to_hms(elapsed, blankzero=False))

print("Peak concurrency: %d out of %d slots\n" % (peak, len(slots)))

print("Slot usage (time in an \"active\" state):  | Concurrency breakdown:\n")
print("#Rank  Slot  Usage        ( Pct )          # of Slots  Usage        ( Pct )")

lines = []

for rank, slotn in enumerate(sorted(slots, key=get_slot_val, reverse=True)):
    slot = slots[slotn]
    pct = (100 * slot["total"] / elapsed) if elapsed > 0.0 else 0.0
    state = " active" if slot["active"] else "       "
    stime = secs_to_hms(slot["total"], blankzero=True)
    lines.append("%s   %s (%04.1f%%)%s" % (slotn, stime, pct, state))

for rank, concurrentn in enumerate(sorted(concurrency, key=get_concurrent_val, reverse=True)):
    concurrent = concurrency[concurrentn]
    pct = (100 * concurrent["total"] / elapsed) if elapsed > 0.0 else 0.0
    stime = secs_to_hms(concurrent["total"], blankzero=True)
    lines[rank] += "       %02d      %s (%04.1f%%)" % (concurrentn, stime, pct)

for rank, line in enumerate(lines):
    print(" #%02d    %s" % (rank + 1, line))
