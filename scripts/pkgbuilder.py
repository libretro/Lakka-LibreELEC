#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

import sys
import os
import datetime, time
import argparse
import json
import codecs
import copy
import threading
import queue
import subprocess
import multiprocessing

# Ensure we can output any old crap to stdout and stderr
sys.stdout = codecs.getwriter("utf-8")(sys.stdout.detach())
sys.stderr = codecs.getwriter("utf-8")(sys.stderr.detach())

# derive from subprocess to utilize wait4() for rusage stats
class RusagePopen(subprocess.Popen):
    def _try_wait(self, wait_flags):
        try:
            (pid, sts, ru) = os.wait4(self.pid, wait_flags)
        except OSError as e:
            if e.errno != errno.ECHILD:
                raise
            pid = self.pid
            sts = 0
        else:
            self.rusage = ru
        return (pid, sts)

def rusage_run(*popenargs, timeout=None, **kwargs):
    with RusagePopen(*popenargs, **kwargs) as process:
        try:
            stdout, stderr = process.communicate(None, timeout=timeout)
        except subprocess.TimeoutExpired as exc:
            process.kill()
            process.wait()
            raise
        except:
            process.kill()
            raise
        retcode = process.poll()
    res = subprocess.CompletedProcess(process.args, retcode, stdout, stderr)
    res.rusage = process.rusage
    return res

class GeneratorEmpty(Exception):
    pass

class GeneratorStalled(Exception):
    pass

class Generator:
    def __init__(self, plan):
        self.plan = plan

        self.work = copy.deepcopy(self.plan)
        self.building = {}
        self.built = {}
        self.failed = {}

        self.check_no_deps = True

    def canBuildJob(self, job):
        for dep in job["deps"]:
            if dep not in self.built:
                return False

        return True

    def getFirstFailedJob(self, job):
        for dep in job["deps"]:
            if dep in self.failed:
                failedjob = self.getFirstFailedJob(self.failed[dep])
                if not failedjob:
                    return self.failed[dep]
                else:
                    return failedjob

        return None

    def getAllFailedJobs(self, job):
        flist = {}
        for dep in job["deps"]:
            if dep in self.failed:
                failedjob = self.getFirstFailedJob(self.failed[dep])
                if failedjob:
                    flist[failedjob["name"]] = failedjob
                else:
                    flist[dep] = self.failed[dep]

        return [flist[x] for x in flist]

    def getNextJob(self):
        if self.work == []:
            raise GeneratorEmpty

        # Always process jobs without dependencies first
        # until we're sure there's none left...
        if self.check_no_deps:
            for i, job in enumerate(self.work):
                if job["deps"] == []:
                    self.building[job["name"]] = True
                    del self.work[i]
                    job["failedjobs"] = self.getAllFailedJobs(job)
                    job["logfile"] = None
                    job["cmdproc"] = None
                    job["failed"] = False
                    return job

            self.check_no_deps = False

        # Process remaining jobs, trying to schedule
        # only those jobs with all their dependencies satisifed
        for i, job in enumerate(self.work):
            if self.canBuildJob(job):
                self.building[job["name"]] = True
                del self.work[i]
                job["failedjobs"] = self.getAllFailedJobs(job)
                job["logfile"] = None
                job["cmdproc"] = None
                job["failed"] = False
                return job

        raise GeneratorStalled

    # Return details about stalled jobs that can't build until the
    # currently building jobs are complete.
    def getStallInfo(self):
        for job in self.work:
            for dep in job["deps"]:
                if dep not in self.building and dep not in self.built:
                    break
            else:
                yield (job["name"], [d for d in job["deps"] if d in self.building])

    def activeJobCount(self):
        return len(self.building)

    def activeJobNames(self):
        for name in self.building:
            yield name

    def failedJobCount(self):
        return len(self.failed)

    def totalJobCount(self):
        return len(self.plan)

    def completed(self, job):
        del self.building[job["name"]]
        self.built[job["name"]] = job
        if job["failed"]:
            self.failed[job["name"]] = job

class BuildProcess(threading.Thread):
    def __init__(self, slot, maxslot, jobtotal, haltonerror, work, complete):
        threading.Thread.__init__(self, daemon=True)

        self.slot = slot
        self.maxslot = maxslot
        self.jobtotal = jobtotal
        self.haltonerror = haltonerror
        self.work = work
        self.complete = complete

        self.active = False

        self.stopping = False

    def stop(self):
        self.stopping = True
        self.work.put(None)

    def isActive(self):
        return self.active == True

    def run(self):
        while not self.stopping:
            job = self.work.get(block=True)
            if job == None or self.stopping:
                break

            self.active = True

            job["slot"] = self.slot
            job["failed"] = self.execute(job)
            job["status"] = "FAIL" if job["failed"] else "DONE"
            self.complete.put(job)

            self.active = False

            if job["failed"] and self.haltonerror:
                break

    def execute(self, job):
        if job["failedjobs"]:
            flist = []
            for fjob in job["failedjobs"]:
                failedinfo = "%s,%s" % (fjob["task"], fjob["name"])
                if fjob["logfile"]:
                    failedinfo = "%s,%s" % (failedinfo, fjob["seq"])
                flist.append(failedinfo)
            failedinfo = ";".join(flist)
        else:
            failedinfo = ""

        job["args"] = ["%s/%s/pkgbuild" % (ROOT, SCRIPTS),
                       "%d" % self.slot, "%d" % job["seq"], "%d" % self.jobtotal, "%d" % self.maxslot,
                       job["task"], job["name"], failedinfo]

        job["start"] = time.time()
        returncode = 1
        try:
            if job["logfile"]:
                with open(job["logfile"], "w") as logfile:
                    cmd = rusage_run(job["args"], cwd=ROOT,
                                     stdin=subprocess.PIPE, stdout=logfile, stderr=subprocess.STDOUT,
                                     universal_newlines=True, shell=False)
                returncode = cmd.returncode
                job["cmdproc" ] = cmd
            else:
                try:
                    cmd = rusage_run(job["args"], cwd=ROOT,
                                     stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
                                     universal_newlines=True, shell=False,
                                     encoding="utf-8", errors="replace")
                    returncode = cmd.returncode
                    job["cmdproc" ] = cmd
                except UnicodeDecodeError:
                    print('\nPKGBUILDER ERROR: UnicodeDecodeError while reading cmd.stdout from "%s %s"\n' % (job["task"], job["name"]), file=sys.stderr, flush=True)
        except Exception as e:
            print("\nPKGBUILDER ERROR: %s exception while executing: %s\n" % (str(e), job["args"]), file=sys.stderr, flush=True)

        job["end"] = time.time()
        job["elapsed"] = job["end"] - job["start"]

        if job["cmdproc"]:
            job["utime"] = job["cmdproc"].rusage.ru_utime
            job["stime"] = job["cmdproc"].rusage.ru_stime
        else:
            job["utime"] = job["stime"] = 0

        if job["elapsed"] == 0.0:
            job["cpu"] = 0.0
        else:
            job["cpu"] = round((job["utime"] + job["stime"]) * 100 / job["elapsed"])

        return (returncode != 0)

class Builder:
    def __init__(self, maxthreadcount, inputfilename, jobglog, loadstats, stats_interval, \
                 haltonerror=True, log_burst=True, log_combine="always", \
                 debug=False, verbose=False, colors=False):
        if inputfilename == "-":
            plan = json.load(sys.stdin)
        else:
            with open(inputfilename, "r") as infile:
                plan = json.load(infile)

        self.generator = Generator(plan)

        self.joblog = jobglog
        self.loadstats = loadstats
        self.stats_interval = int(stats_interval)
        if self.stats_interval < 1:
            self.stats_interval = 60

        self.haltonerror = haltonerror
        self.log_burst = log_burst
        self.log_combine = log_combine
        self.debug = debug
        self.verbose = verbose

        self.colors = (colors == "always" or (colors == "auto" and sys.stderr.isatty()))
        self.color_code = {}
        self.color_code["DONE"] = "\033[0;32m" #green
        self.color_code["FAIL"] = "\033[1;31m" #bold red
        self.color_code["ACTV"] = "\033[0;33m" #yellow
        self.color_code["IDLE"] = "\033[0;35m" #magenta
        self.color_code["INIT"] = "\033[0;36m" #cyan

        self.work = queue.Queue()
        self.complete = queue.Queue()

        self.jobtotal = self.generator.totalJobCount()
        self.twidth = len("%d" % self.jobtotal)

        self.joblogfile = None
        self.loadstatsfile = None
        self.nextstats = 0

        self.build_start = 0

        # work and completion sequences
        self.cseq = 0
        self.wseq = 0

        # parse threadcount
        if maxthreadcount.endswith("%"):
            self.threadcount = int(multiprocessing.cpu_count() / 100 * int(args.max_procs.replace("%","")))
        else:
            if args.max_procs == "0":
                self.threadcount = 256
            else:
                self.threadcount = int(maxthreadcount)

        self.threadcount = 1 if self.threadcount < 1 else self.threadcount
        self.threadcount = self.jobtotal if self.jobtotal <= self.threadcount else self.threadcount

        if args.debug:
            DEBUG("THREADCOUNT#: input arg: %s, computed: %d" % (maxthreadcount, self.threadcount))

        # Init all processes
        self.processes = []
        for i in range(1, self.threadcount + 1):
            self.processes.append(BuildProcess(i, self.threadcount, self.jobtotal, haltonerror, self.work, self.complete))

    def build(self):
        if self.joblog:
            self.joblogfile = open(self.joblog, "w")

        if self.loadstats:
            self.loadstatsfile = open(self.loadstats, "w")

        self.startProcesses()

        self.build_start = time.time()

        # Queue new work until no more work is available, and all queued jobs have completed.
        while self.queueWork():
            job = self.getCompletedJob()

            self.writeJobLog(job)
            self.processJobOutput(job)
            self.displayJobStatus(job)

            job["cmdproc"] = None
            job = None

            if self.generator.failedJobCount() != 0 and self.haltonerror:
                break

        self.captureStats(finished=True)
        self.stopProcesses()

        if self.joblogfile:
            self.joblogfile.close()

        if self.loadstatsfile:
            self.loadstatsfile.close()

        return (self.generator.failedJobCount() == 0)

    # Fill work queue with enough jobs to keep all processes busy.
    # Return True while jobs remain available to build, or queued jobs are still building.
    # Return False once all jobs have been queued, and finished building.
    def queueWork(self):
        try:
            for i in range(self.generator.activeJobCount(), self.threadcount):
                job = self.generator.getNextJob()

                if self.verbose:
                    self.vprint("INIT", "submit", job["name"])

                if self.debug:
                    DEBUG("Queueing Job: %s %s" % (job["task"], job["name"]))

                self.wseq += 1
                job["seq"] = self.wseq
                if self.log_burst:
                    job["logfile"] = "%s/logs/%d.log" % (THREAD_CONTROL, job["seq"])

                self.work.put(job)

            if self.verbose:
                self.vprint("ACTV", "active", ", ".join(self.generator.activeJobNames()))

            if self.debug:
                freeslots = self.threadcount - self.generator.activeJobCount()
                DEBUG("Building Now: %d active, %d idle [%s]" % (self.generator.activeJobCount(), freeslots, ", ".join(self.generator.activeJobNames())))

        except GeneratorStalled:
            if self.verbose:
                freeslots = self.threadcount - self.generator.activeJobCount()
                pending = []
                for (i, (package, wants)) in enumerate(self.generator.getStallInfo()):
                    pending.append("%s (wants: %s)" % (package, ", ".join(wants)))
                self.vprint("ACTV", "active", ", ".join(self.generator.activeJobNames()))
                self.vprint("IDLE", "stalled", "; ".join(pending), p1=len(pending))

            if self.debug:
                freeslots = self.threadcount - self.generator.activeJobCount()
                DEBUG("Building Now: %d active, %d idle [%s]" % (self.generator.activeJobCount(), freeslots, ", ".join(self.generator.activeJobNames())))
                for (i, (package, wants)) in enumerate(self.generator.getStallInfo()):
                    item = "%-25s wants: %s" % (package, ", ".join(wants))
                    if i == 0:
                        DEBUG("Stalled Jobs: %s" % item)
                    else:
                        DEBUG("              %s" % item)

        except GeneratorEmpty:
            if self.generator.activeJobCount() == 0:
                if self.debug:
                    DEBUG("NO MORE JOBS: All jobs have completed - exiting.")
                return False
            else:
                if self.debug:
                    n = self.generator.activeJobCount()
                    DEBUG("NO MORE JOBS: Waiting on %d job%s to complete..." % (n, ["s",""][n == 1]))

        return True

    # Wait until a new job is available
    def getCompletedJob(self):
        while True:
            try:
                job = self.complete.get(block=True, timeout=self.captureStats(finished=False))
                self.generator.completed(job)

                if self.debug:
                    DEBUG("Finished Job: %s %s [%s] after %0.3f seconds" % (job["task"], job["name"], job["status"], job["elapsed"]))

                return job

            except queue.Empty:
                pass

    def captureStats(self, finished=False):
        if not self.loadstatsfile:
            return None

        now = time.time()
        if now >= self.nextstats or finished:
            self.nextstats = int(now - (now % self.stats_interval)) + self.stats_interval

            loadavg = open("/proc/loadavg", "r").readline().split()
            procs = loadavg[3].split("/")
            meminfo = dict((i.split()[0].rstrip(':'),int(i.split()[1])) for i in open("/proc/meminfo", "r").readlines())

            print("%d %06d %5s %5s %5s %3s %4s %9d %2d %s" % (now, now - self.build_start, \
                  loadavg[0], loadavg[1], loadavg[2], procs[0], procs[1], meminfo["MemAvailable"], \
                  self.generator.activeJobCount(), ",".join(self.generator.activeJobNames())), \
                  file=self.loadstatsfile, flush=True)

        return (self.nextstats - time.time())

    # Output progress info, and links to any relevant logs
    def displayJobStatus(self, job):
        self.cseq += 1
        print("[%0*d/%0*d] [%s] %-7s %s" %
              (self.twidth, self.cseq, self.twidth, self.jobtotal,
               self.colorise(job["status"]), job["task"], job["name"]), file=sys.stderr, flush=True)

        if job["failed"]:
            if job["logfile"]:
                print("\nThe following log for this failure is available:\n  %s\n" % job["logfile"], \
                      file=sys.stderr, flush=True)

            if job["failedjobs"] and job["failedjobs"][0]["logfile"]:
                if len(job["failedjobs"]) == 1:
                    print("The following log from the failed dependency may be relevant:", file=sys.stderr)
                else:
                    print("The following logs from the failed dependencies may be relevant:", file=sys.stderr)
                for fjob in job["failedjobs"]:
                    print("  %-7s %s => %s" % (fjob["task"], fjob["name"], fjob["logfile"]), file=sys.stderr)
                print("", file=sys.stderr)
                sys.stderr.flush()

    # If configured, send output for a job (either a logfile, or captured stdout) to stdout
    def processJobOutput(self, job):
        log_processed = False
        log_size = 0
        log_start = time.time()

        if job["logfile"]:
            if self.log_combine == "always" or (job["failed"] and self.log_combine == "fail"):
                try:
                    with open(job["logfile"], "r", encoding="utf-8", errors="replace") as logfile:
                        for line in logfile:
                            print(line, end="")
                            if self.debug:
                                log_size += len(line)
                except UnicodeDecodeError:
                    print("\nPKGBUILDER ERROR: UnicodeDecodeError while reading log file %s\n" % job["logfile"], file=sys.stderr, flush=True)

                if job["failed"]:
                    print("\nThe following log for this failure is available:\n  %s\n" % job["logfile"])

                sys.stdout.flush()
                log_processed = True

        elif job["cmdproc"]:
            if self.log_combine == "always" or (job["failed"] and self.log_combine == "fail"):
                for line in job["cmdproc"].stdout:
                    print(line, end="", file=sys.stdout)
                    if self.debug:
                        log_size += len(line)
                sys.stdout.flush()
                log_processed = True

        log_elapsed = time.time() - log_start

        if self.debug and log_processed:
            log_rate = int(log_size / log_elapsed) if log_elapsed != 0 else 0
            log_data = ", %s" % "/".join(job["logfile"].split("/")[-2:]) if job["logfile"] else ""
            DEBUG("WRITING LOG : {0:,} bytes in {1:0.3f} seconds ({2:,d} bytes/sec{3:})".format(log_size, log_elapsed, log_rate, log_data))

    # Log completion stats for job
    def writeJobLog(self, job):
        if self.joblogfile:
            print("{j[status]} {j[seq]:0{width}} {j[slot]} {j[task]} {j[name]} " \
                  "{j[utime]:.{prec}f} {j[stime]:.{prec}f} {j[cpu]} " \
                  "{j[elapsed]:.{prec}f} {j[start]:.{prec}f} {j[end]:.{prec}f} {0}" \
                  .format(job["logfile"] if job["logfile"] else "",
                          j=job, prec=4, width=self.twidth),
                  file=self.joblogfile, flush=True)

    def startProcesses(self):
        for process in self.processes:
            process.start()

    def stopProcesses(self):
        for process in self.processes:
            process.stop()

    def vprint(self, status, task, data, p1=None, p2=None):
       p1 = (self.threadcount - self.generator.activeJobCount()) if p1 == None else p1
       p2 = self.generator.activeJobCount() if p2 == None else p2
       print("[%0*d/%0*d] [%4s] %-7s %s" %
           (self.twidth, p1, self.twidth, p2,
            self.colorise(status), task, data), file=sys.stderr, flush=True)

    def colorise(self, item):
        if self.colors:
            return "%s%-4s\033[0m" % (self.color_code[item], item)
        return item

def DEBUG(msg):
    if DEBUG_LOG:
        print("%s: %s" % (datetime.datetime.now(), msg), file=DEBUG_LOG, flush=True)

parser = argparse.ArgumentParser(description="Run processes to build the specified JSON plan", \
                                 formatter_class=lambda prog: argparse.HelpFormatter(prog,max_help_position=25,width=90))

parser.add_argument("--max-procs", required=False, default="100%", \
                    help="Maximum number of processes to use. 0 is unlimited. Can be expressed as " \
                         "a percentage, for example 50%% (of $(nproc)). Default is 100%%.")

parser.add_argument("--plan", metavar="FILE", default="-", \
                    help="JSON formatted plan to be processed (default is to read from stdin).")

parser.add_argument("--joblog", metavar="FILE", default=None, \
                    help="File into which job completion information will be written.")

parser.add_argument("--loadstats", metavar="FILE", default=None, \
                    help="File into which load average and memory statistics will be written.")

parser.add_argument("--stats-interval", metavar="SECONDS", type=int, default=60, \
                    help="Sampling interval in seconds for --loadstats. Default is 60.")

group =  parser.add_mutually_exclusive_group()
group.add_argument("--log-burst", action="store_true", default=True, \
                    help="Burst job output into individual log files. This is the default.")
group.add_argument("--no-log-burst", action="store_false", dest="log_burst", \
                    help="Disable --log-burst, job output is only written to stdout.")

group =  parser.add_mutually_exclusive_group()
group.add_argument("--log-combine", choices=["always", "never", "fail"], default="always", \
                    help='Choose when to send job output to stdout. "fail" will send to stdout the ' \
                         'log of failed jobs only, while "never" will not send any logs to stdout. ' \
                         'Default is "always".')

group =  parser.add_mutually_exclusive_group()
group.add_argument("--halt-on-error", action="store_true", default=True, \
                    help="Halt on first build failure. This is the default.")
group.add_argument("--continue-on-error", action="store_false", dest="halt_on_error", \
                    help="Disable --halt-on-error and continue building.")

parser.add_argument("--verbose", action="store_true", default=False, \
                    help="Output verbose information to stderr.")

parser.add_argument("--debug", action="store_true", default=False, \
                    help="Enable debug information.")

parser.add_argument("--colors", choices=["always", "never", "auto"], default="auto", \
                    help="Color code status (DONE, FAIL, etc) labels.")

args = parser.parse_args()

#---------------------------

ROOT = os.environ.get("ROOT", os.path.dirname(os.path.dirname(os.path.realpath(__file__))))
SCRIPTS = os.environ.get("SCRIPTS", "scripts")
THREAD_CONTROL = os.environ["THREAD_CONTROL"]

if args.debug:
    debug_log = "%s/debug.log" % THREAD_CONTROL
    DEBUG_LOG = open(debug_log, "w")
    print("Debug information is being written to: %s\n" % debug_log, file=sys.stderr, flush=True)
else:
    DEBUG_LOG = None

with open("%s/parallel.pid" % THREAD_CONTROL, "w") as pid:
    print("%d" % os.getpid(), file=pid)

try:
    result = Builder(args.max_procs, args.plan, args.joblog, args.loadstats, args.stats_interval, \
                     haltonerror=args.halt_on_error, \
                     log_burst=args.log_burst, log_combine=args.log_combine, \
                     colors=args.colors, debug=args.debug, verbose=args.verbose).build()

    if DEBUG_LOG:
        DEBUG_LOG.close()

    sys.exit(0 if result else 1)
except (KeyboardInterrupt, SystemExit) as e:
    if type(e) == SystemExit:
        sys.exit(int(str(e)))
    else:
        sys.exit(1)

