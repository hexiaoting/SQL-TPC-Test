#!/usr/bin/env python
import os
import psutil
import sys
from getpass import getuser
from time import sleep, time


KILL_TIMEOUT_IN_SECONDS = 240

def find_user_processes(binaries):
  """Returns an iterator over all processes owned by the current user with a matching
  binary name from the provided list."""
  for process in psutil.process_iter():
    try:
      pinfo = process.as_dict(attrs=['pid', 'name'])
      #print "process:%s" % process.name
      #if pinfo.get('name') in binaries: print "process:%s" % process.name
      if pinfo.get('name') in binaries: yield process
      #if process.username == getuser() and process.name in binaries: yield process
    except KeyError, e:
      if "uid not found" not in str(e):
        raise
    except psutil.NoSuchProcess, e:
      # Ignore the case when a process no longer exists.
      pass

def exec_impala_process(cmd, args, stderr_log_file_path):
  redirect_output = str()
  if options.verbose:
    args += ' -logtostderr=1'
  else:
    redirect_output = "1>%s" % stderr_log_file_path
  cmd = '%s %s %s 2>&1 &' % (cmd, args, redirect_output)
  os.system(cmd)

def kill_cluster_processes(force=False):
  binaries = ['catalogd', 'impalad', 'statestored', 'mini-impala-cluster']
  kill_matching_processes(binaries, force)

def kill_matching_processes(binary_names, force=False):
  """Kills all processes with the given binary name, waiting for them to exit"""
  # Send all the signals before waiting so that processes can clean up in parallel.
  processes = list(find_user_processes(binary_names))
  print "process %s" % processes
  for process in processes:
    try:
      if force:
	print "kill"
        process.kill()
      else:
	print "terminate"
        process.terminate()
    except psutil.NoSuchProcess:
      pass

  for process in processes:
    try:
      process.wait(KILL_TIMEOUT_IN_SECONDS)
    except psutil.TimeoutExpired:
      raise RuntimeError("Unable to kill %s (pid %d) after %d seconds." % (process.name,
          process.pid, KILL_TIMEOUT_IN_SECONDS))

if __name__ == "__main__":
    kill_cluster_processes()
    sys.exit(0)
