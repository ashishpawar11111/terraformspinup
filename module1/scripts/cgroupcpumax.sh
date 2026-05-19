#!/bin/bash
#Step 1: Create a new cgroup
sudo mkdir /sys/fs/cgroup/testcpu
#Step 2: Set CPU limits (e.g., 50% of CPU time)
echo "50000 100000" | sudo tee /sys/fs/cgroup/testcpu/cpu.max
#Step 3: Run a test process, Find its PID:, and Add the process to the cgroup
yes > /dev/null & echo $(pidof yes) | sudo tee /sys/fs/cgroup/testcpu/cgroup.procs


#Step 5: Verify Use top or htop to check CPU usage. 
#The process should hover around 50% of one core instead of maxing out.