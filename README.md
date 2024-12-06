# Server-Performance-Stats

link to the project : https://roadmap.sh/projects/server-stats

Write a script to analyse basic server performance stats.

Goal of this project is to write a script to analyse server performance stats.

### Requirements

You are required to write a script server-stats.sh that can analyse basic server performance stats. You should be able to run the script on any Linux server and it should give you the following stats:

Total CPU usage
Total memory usage (Free vs Used including percentage)
Total disk usage (Free vs Used including percentage)
Top 5 processes by CPU usage
Top 5 processes by memory usage

Stretch goal: Feel free to optionally add more stats such as os version, uptime, load average, logged in users, failed login attempts etc.

## Installation

### Clone the repository

```
git clone git@github.com:guillaume-pages/Server-Performance-Stats.git
```

### How to use ?

In your terminal, enter the following command.

```
bash server-performance-stat.sh
```

If you encounter somme issues do the permission, you can try this command.

```
chmod +x server-performance-stat.sh
```

The ouput will be this :

```
== Server Performance Stat ==
=============================
CPU Usage: 6%

=============================
Memory total : 15728 MB
Memory used : 4450 MB
Memory free : 11277 MB
Percentage memory used : 28%

=============================
Total Disk Space: 106,42 GB
Used Disk Space: 32,23 GB
Free Disk Space: 69,29 GB
Disk Usage: 30,2839%

==== Top 5 Processes by CPU Usage ====
    PID COMMAND         %CPU
  11672 chrome           8.9
   3869 chrome           8.0
   4230 slack            4.3
   2673 Xorg             3.6
   2985 gnome-shell      3.6

==== Top 5 Processes by Memory Usage ====
    PID COMMAND         %MEM
   4230 slack            2.3
   3714 chrome           2.2
   2985 gnome-shell      2.1
  12739 code             2.0
  11672 chrome           1.8

=============================
System: Ubuntu 24.04.1 LTS

=============================
```