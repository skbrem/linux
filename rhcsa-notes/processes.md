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
| `Ctrl-C` | Used to cancel the current interative job. |
| `bg` | Jobs paused with `Ctrl-Z` will be moved to the background. |
| `fg` | Brings the last job to the foreground. |
| `jobs` | Shows which jobs are currently running from this shell. |

### Parent-Child Relations

Once a process is created from a shell, it becomes a child process of that shell. The parent-child relationship between processes is important to understand as the parent is needed to manage the child. Processes that are started in the background will not be killed when the parent shell from which they were started is killed. In order to terminate these specific processes, the `kill` command is needed.

## Process Managment Tools

On average there are usually over 100 active processes at any given time, and being able to manage them is an important skill that every admin needs to know.


