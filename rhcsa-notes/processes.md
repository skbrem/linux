## Process Management

A process is created for everything that happens on a Linux system. This means that an admin must master process management to have full control of the system. Knowing the type of process is an essential part of this. There are three main process types:

- **Shell jobs**: are commands that are started from the command line. These are directly associated with the shell that was in use when the process was started. These are also known as *interactive processes*.
- **Daemons**: These are processes that provide services. These are started when the computer is booted and often (but not always) run with root privilages.
- **Kernel threads**: These are a part of the kernel. They cannot be managed using common tools, but it's a good idea to watch kernel threads in order to monitor how the system is functioning.

When a process is created, it's capable of using multiple threads. A thread is a task that is started by a process which is then serviced by the CPU. There are no tools offered by the shell to manage threads directly, and all thread management should instead be managed within the command.

## Shell Jobs

When a command is typed, a shell job is created. Unless commanded otherwise, the job is created as a foreground process, which occupies the terminal it was started from until the job has been finished. It's also important to know how to start jobs as background processes.

### Foreground and Background

By default, processes are started in the foreground, which means that the terminal cannot be interacted with until the task is complete. Usually this is not an issue as many tasks don't take long to finish, but sometimes it's a better idea to instead start jobs in the background. 

For jobs that are going to take a long time to finish, it may be worth putting a `&` behind the command. This command begins the job in the background and allows the user to continue using the on the command line. To move the last background job to the foreground, use the `fg` command. If there are multiple jobs that are running in the background, it's possible to move a chosen job to the foreground by adding the job ID, which can be viewed with the `jobs` command.

If a job is taking too long, it's possible to temporarily pause the job by using `Ctrl-Z`. The job is not removed from memory, is simply pauses the job to give the admin the chance to manage it. Once the job is paused, it's possible to continue it in the background with the `bg` command. Another common key sequence that's worth knowing is `Ctrl-C`, which stops the current job and also removes it from memory.

Another key combination is `Ctrl-D`, which then sends an End of Life (EOF) character to the job. The result is that the job is stops waiting for more input from the user so that it's able to complete what it was doing. Pressing `Ctrl-D` is sometimes similar to using `Ctrl-C` but there is a difference. When `Ctrl-C` is used, the job is simply cancelled, and nothing is closed properly. `Ctrl-D`, on the other hand, the job stops waiting for more input and then terminates, which means that is close in a complete way.

### Managing Shell Jobs

| Command | Description |
| --- | --- |
| `&` | Starts command in the background (use at the end of the command.) |
| `Ctrl-Z` | Stops the job temporarily so it can be managed. |
| `Ctrl-D` | Sends the EOF character to the current job to indicate it should stop waiting for input. |
| `Ctrl-C` | Used to cancel the current interactive job. |
| `bg` | Jobs paused with `Ctrl-Z` will be moved to the background. |
| `fg` | Brings the last job to the foreground. |
| `jobs` | Shows which jobs are currently running from this shell. |

### Parent-Child Relations

Once a process is created from a shell, it becomes a child process of that shell. The parent-child relationship between processes is important to understand as the parent is needed to manage the child. Processes that are started in the background will not be killed when the parent shell from which they were started is killed. In order to terminate these specific processes, the `kill` command is needed.

## Process Managment Tools

On average there are usually over 100 active processes at any given time, and being able to manage them is an important skill that every admin needs to know.

### Processes and Threads

In general, tasks that are started on Linux are done so in the form of processes, and a single process is able to start a number of worker threads. Threads make things easier because it allows a single process to work with different CPUs and GPUs. We are not able to manage individual threads, instead we manage the processes that control them. 

There are two different kinds of background processes: daemon processes and kernel threads. Kernel threads are a part of the Linux kernel, and each one is started with its own process identification number (PID). Processes are easy to manage because they have a name that sits between square brackets. This is easy to see by using the command: `ps aux | head`.

### `ps`

`ps` remains the most common tool available to get an overview of the currently running processes. If there are no arguments used, the `ps` command only shows processes that have been started by the user. There are many different arguments that can be used to show more information about the different processes that are running at any given time. For instance, to see the name of the process as well as the command that was used to start that process, try `ps -ef`. Another helpful command is `ps -fax` which shows the hierarcy between parent and child processes.

`ps` is among the few commands where a hyphen does not need to preceed the arguments, meaning that `ps aux` is just as viable as `ps -aux` and will display the same output.

The PID is an important part of the `ps` command, as many tasks need a PID in order to operate, and that's why using a command like `ps aux | grep dd` is quite common, as it shows the details about the `dd` process. An alternative method of getting the same information is with the `pgrep` command, such as `pgrep dd`.

### Process Priorities

In Linux, cgroups are used to allocate resources. There are three system areas in cgroup, called slices, and include:

- **system**: Where all processes are shown that are managed by systemd.
- **user**: Where all user processes are running, including those by root.
- **machine**: An option slice that's for virtual machines and containers.

All slices have the same CPUWeigh, which means that the CPU cycles are divided equally if there is high demand. All of the processes that are running are running within the system slice get as many CPU cycles as those that running in the user slice. Within a slice, the priority of a process is managed by using either `nice` or `renice`.

### Process Priorities

All regular processes by default are started with the same priority, which is the number 20. It's possible to change the default process priority to the process when it's started using `nice` and `renice`. `nice` is used when starting a process with an adjusted priority, while `renice` is used to change the priority for an active process. Another way of doing it is by using the `r` command with the `top` utility. 

The values that can be used with `nice` and `renice` range from -20 to 19, and the default niceness of a process is set ot 0, which has a priority value of 20. Applying a negative value will increase the priority, while the opposite is true of a positive value. It's not recommended to use the ultimate values when making changes; rather increment by 5 and monitor how it affects the process in question.

### Process Signals

Every process has a parent process, and as long as it's alive, the parent process is responsible for the child process that is has created. In newer versions of Linux, killing a parent process will make all of its child processes the children of the systemd process. This is not the same for older versions of the kernel, where killing a parent process would also kill the child processes along with it. There are many different kinds of signals that are available on Linux, and they can be viewed by using `man 7 signal`.

The following are common signals:

- **SIGTERM (15)**: Used to ask a process to stop.
- **SIGTERM (9)**: Used for force a process to stop.
- **SIGHUP (1)**: Used to hang up a process. The process will then reread its config files, which is helpful if there have been modifications that have been made to the config file.

The `kill` command is used to send a signal to a process, and most commonly this is done to make a process stop. This is done by using the `kill` command followed by the PID of the process, which then sends the SIGTERM signal to the process, which typically will then cause the process to stop all activity.

There are times when the `kill` command does not work because the process in question ignores it. If this happens, the `kill -9` command will send a SIGKILL signal to the process, and this signal cannot be ignore. While it may be necessary to use `kill -9` when a process refuses to stop, this can also cause a loss of data, and could also cause the system to become unstable if other processes rely on the process that's causing the problem. For these reasons it's generally recommended to avoid using `kill -9` wherever possible.

>[!tip]
> The `kill -l` command can be used to show a list of all signals that can be used with `kill`.

There are other commands that are related to `kill`. These are `killall`, and `pkill`. `pkill` is sometimes easier to use as it requires the name of the process rather than the PID. It's also possible to use the `killall` command to kill a number of processes that are all sharing the same name, but there is a risk involved in this. It's usually a good idea to use the `kill` command followed by the specific PID of the process that needs to be killed.


### Zombies

Zombie processes are processes that have finished their execution but remain in the process table. It's possible to find any zombie processes with the following command:

```sh
ps aux | grep defunct
```

Zombie processes are harmless but they are annoying and worth cleaning up if there are many of them. Zombie are unable to be killed with the usual way of killing processes, and sometimes the easiest way to clean up all of the zombie processes is by rebooting the system.

### `top`

Among the most convenient tools on a Linux system is `top`. It provides an overview of the most active processes that are running on the system. The following table provides an overview of the information that `top` provides.

| State | Description |
| --- | --- |
| Running (R) | The process is active, or waiting in the queue to get services. |
| Sleeping (S) | The process is waiting for an event to complete. |
| Uninterruptible sleep (D) | Also known as blocking state. The process is in a sleep state and cannot be stopped. |
| Stopped (T) | The process has stopped. |
| Zombie (Z) | Has been stopped but was not removed by the parent. |

`top` is helpful when combined with the `kill` command. For instance, we can go into `top` and then type `k`, which will then prompt the user to provide a PID to kill. By default this will select the process that is the most active. After entering the PID, `top` will then prompt for the SIGKILL to use. It will default to signal 15 for SIGTERM, but it's also possible to use 9.

To use `top` to renice, use `r` after opening `top`. First it will prompt for a PID, and once that's been entered, it will prompt for the nice value. Enter a positive value to decrease the priority or a negative value to increase the priority.

We can also use `top` to get informationa about load averages, which is expressed as the number of processes that are in a runnable state (R), or in a blocking state (D). Processes that are in a runnable state are either already running or are waiting for waiting to be serviced. Blocking state processes are in a blocking state whike they wait for I/O. The load average on `top` is shown for the last 1, 5, and 15 minutes, and the current values are displayed at the top right corner of the screen. Another command provides the load average is `uptime`.

Typically, the load average should not be higher than the number of cores that are in the system. The `lscpu` command is used to show the number of cores that are available. If the load average over a period of time is more than the number of cores in the system, there may be a performance issue.

### Using `tuned`

When installed, `tuned` will automatically select a profile based on the system, but it is possible to also change the profile after it has been installed.

| Profile | Usage |
| --- | --- |
| balanced | Compromise between performance and power usage. |
| desktop | Better response to interactive applications. |
| latency-performance | Maximum throughput. |
| network-latency | Reduces network latency. |
| powersave | Maximum power saving. |
| throughput-performance | Maximum throughput. |

`tuned` is used with the `tuned-adm` command. For instance:

`tuned-adm active` shows which profile is currently in use.
`tuned-adm recommend` shows which profile `tuned` recommends.
`tuned-adm powersave` will switch the profile to `powersave`.


