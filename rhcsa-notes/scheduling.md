## Systemd Timers

Systemd timers have become the preferred way of scheduling tasks on modern Linux systems. A timer is always used alongside a service file, and the names should always match to ensure that they work together. The service unit defines how the service is meant to be started, while the timer defines when it's meant to be started.

Most `.timer` files contain the following:

- **OnCalendar**: This describes when the timer should execute.
- **AccuracySec**: The time window in which an action should execute.
- **Persistent**: Modifier for OnCalendar=daily, it specifies that that the last execution should be stored, so that it always executes one day later compared to its last execution time.

The following are some more timer options.

| Option | Description |
| --- | --- |
| OnActiveSec | Defines the timer relative to the time that the timer is started. |
| OnBootSec | Defines a timer relative to the last boot. |
| OnStartupSec | Defines a time relative to when the service manager was started. |
| OnUnitActiveSec | Defines a timer relative to when the unit that timer starts was last started. |
| OnCalendar | Defines a timer based on calendar event expressions, such as daily. |

It's possible to learn more using the `man systemd.time` to learn more about the different timer options.

## Cron

Scheduling has been a part of the Linux ecosystem for a long time, and in the past scheduling was largely done with the `crond` service. This service is made of two main parts. The first is the daemon `crond`, which is usually started as a system service on many modern distros. The daemon will look every minute to see whether there is a task to complete. Next, the work that needs to be completed is defined within the cron configuration, which is made up of multiple files that work together to provide the correct information to the services that need it at specific times. Although systemd timers are the preferred way of scheduling tasks on a Linux system, there are still some scenarios where cron is worth choosing instead.

### Managing Cron

The `crond` service is started by default on most distros. Managing the service is simple, partly because it does not require that much management. In order to check the status of the `crond` service, use the following command: `systemctl status crond`.

### `cron` Timing

When scheduling tasks using `cron`, it's important to specificy when exactly the services need to be started. This is done in the crontab configuration, where a time string is used to indicate when tasks are meant to be started. The following table shows the time and date fields that are used:

| Field | Value |
| --- | --- |
| minute | 0-59 |
| hour | 0-23 |
| day of month | 1-31 |
| month | 1-12 or name of months |
| day of week | 0-7 or day names (Sunday is 0 or 7) |

It's possible to add a wildcard `*` in any of these fields, which is used to refer to any value. Range of numbers can be used, along with lists and patterns. Examples include:

- `5 0 * * *`: Run every day at 5 minutes after midnight.
- `15 14 1 * *`: Run at 14:15 on the first day of every month.
- `0 22 * * 1-5`: Run on weekdays at 22:00.
- `0 4 8-14 * *`: Run on every second Saturday of the month.

Check out `man 5 crontab` to see all the possible timing combinations.

### Cron Config Files

The main config file for `cron` can be found at `/etc/crontab`, but it's not possible to alter this file directly, although it does provide a good overview of the timings and other options for `cron`. It's also used to set environmental variables that are used by other commands which are executed by `cron`. This is what we get when running `cat /etc/crontab`:

```sh
# /etc/crontab: system-wide crontab
# Unlike any other crontab you don't have to run the `crontab'
# command to install the new version when you edit this file
# and files in /etc/cron.d. These files also have username fields,
# that none of the other crontabs do.

SHELL=/bin/sh
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# Example of job definition:
# .---------------- minute (0 - 59)
# |  .------------- hour (0 - 23)
# |  |  .---------- day of month (1 - 31)
# |  |  |  .------- month (1 - 12) OR jan,feb,mar,apr ...
# |  |  |  |  .---- day of week (0 - 6) (Sunday=0 or 7) OR sun,mon,tue,wed,thu,fri,sat
# |  |  |  |  |
# *  *  *  *  * user-name command to be executed
17 *    * * *   root    cd / && run-parts --report /etc/cron.hourly
25 6    * * *   root    test -x /usr/sbin/anacron || { cd / && run-parts --report /etc/cron.daily; }
47 6    * * 7   root    test -x /usr/sbin/anacron || { cd / && run-parts --report /etc/cron.weekly; }
52 6    1 * *   root    test -x /usr/sbin/anacron || { cd / && run-parts --report /etc/cron.monthly; }
#
```

Instead of directly modifying `/etc/crontab`, we modify different `cron` configuration files, including:

- The `cron` files in `/etc/cron.d`.
- Scripts that are in `/etc/cron.hourly`, `/etc/cron.daily`, `cron.weekly`, and `cron.monthly`.
- Any files that are specific to the user created with the `crontab -e` command.

`cron` jobs can be started for specific users. In order to create a job for a specific user, use the `crontab -e` command after logging in as that user, otherwise the following command can be used from a different account: `crontab -e -u username`. This is the most common way of using `cron` for scheduling tasks.

When `crontab -e` is used, the default editor for the system will open and a temporary file is created. After the configuration has been edited, the temporary file is moved to its final location and in the directory `/var/spool/cron`. Within this directory, a file is made for each user, and it's important to note that these files should never be edited directly. When the file is saved by `crontab -e`, the is automatically activated.

In order to add `cron jobs`, it's possible to add files to the `/etc/cron.d` directory, and it should work as long as the file conforms to the syntax of a normal cron job. As mentioned, other ways of schedule jobs is through the following directories:

- `/etc/cron.hourly`
- `/etc/cron.daily`
- `/etc/cron.weekly`
- `/etc/cron.monthly`

Typically we find scripts rather than files in these directories that are put in here by packages. There is no information about timings in the scripts that are within these directories, as the timing is handled automatically depending on which directory the script has been placed in.

### anacron

To ensure that a job is executed as expected, `cron` makes use of `anacron`. `anacron` takes care of starting the hourly, daily, weekly, and monthly `cron` jobs. To determine how this is done, `anacron` uses the `etc/anacrontab` file.

It's worth noting that there is no easy way of getting a comprehensive overview of all the cron jobs that have been scheduled, and there is no single command available that shows all the currently scheduled jobs. The `crontab -l` command lists cron jobs, but only for the current account.

### `cron` Security

By default, all users on a system are able to start cron jobs, but it's also possible to limit which users are allowed to schedule cron jobs by modifying the `/etc/cron.allow` and the `/etc/cron.deny` files. If the `cron.allow` file is present on the system, then a user needs to be listed on it in order to be allowed to use cron. If the `cron.deny` file exists on the system, a user must not be listed on it in order to make use of cron. Both files are not allowed to exist on the system at the same time. If neither file exists, only root is able to use cron.

## `at`


