#!/usr/bin/env python3
import os
import json
import time
import logging
import logging.handlers

# --- Syslog setup ---
logger = logging.getLogger("cgroup_monitor")
logger.setLevel(logging.INFO)
handler = logging.handlers.SysLogHandler(address="/dev/log")
logger.addHandler(handler)

def log_event(event_type, details):
    entry = {
        "event": event_type,
        "timestamp": time.strftime("%Y-%m-%dT%H:%M:%S"),
        "details": details
    }
    logger.info(json.dumps(entry))

# --- Audit /proc/net ---
def audit_proc_net():
    try:
        with open("/proc/net/dev") as f:
            net_data = f.read()
        log_event("proc_net", {"net_dev": net_data})
    except Exception as e:
        log_event("error", {"proc_net": str(e)})

# --- Audit /proc/sys ---
def audit_proc_sys():
    sys_settings = {}
    for root, dirs, files in os.walk("/proc/sys/net"):
        for file in files:
            path = os.path.join(root, file)
            try:
                with open(path) as f:
                    sys_settings[path] = f.read().strip()
            except Exception:
                continue
    log_event("proc_sys", sys_settings)

# --- Cgroup awareness ---
def audit_cgroups():
    cgroup_info = {}
    try:
        with open("/proc/self/cgroup") as f:
            for line in f:
                parts = line.strip().split(":")
                if len(parts) == 3:
                    subsys, _, path = parts
                    cgroup_info[subsys] = path
        log_event("cgroup", cgroup_info)
    except Exception as e:
        log_event("error", {"cgroup": str(e)})

# --- Main loop ---
if __name__ == "__main__":
    while True:
        audit_proc_net()
        audit_proc_sys()
        audit_cgroups()
        time.sleep(60)  # run every minute
