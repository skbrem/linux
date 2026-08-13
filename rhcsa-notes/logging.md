## System Logging

There are three different systems in place that log all of the information on a Linux server. These include the following:

- Systemd-journald: This service is a part of systemd, and it's possible for admins to read system information using commands like `systemctl status` and `journalctl`. Systemd-journald had become the default logging service for most modern distros.
- Direct write: Some services will write information directly to log files, even some important services like Apache. This kind of logging is not typically recommended.
- rsyslogd: rsyslogd is an improved version of syslog, which is a service that takes care of managing all centralised logging activities. syslogd has been around for a long time, and while most default logging is done by systemd-journald, there are some things that it's not able to do, and this is where syslogd comes into play.

## Systemd-journald and rsyslogd

Systemd-journal provides a comprehensive and advanced log management system. It collects information from the kernel, the boot sequence, and all services. This all then written to en event journal, which is stored in a binary format that can be queried by using the `journalctl` command. `journalctl` enables an admin to access a deep level of detail about the messages that are logged by the system. 

The journal that is written by systemd-journal is not persistent between boots, so messages are also sent to the rsyslog service, which then writes those messages to different files within the `/var/log` directory. rsyslog also provides features that aren't a part of journald, including centralised logging and the ability to filter messages by using modules. There are many different models available that improve rsyslog logging, such as output modules which allow admins to store messages within a database.

Systemd-journal is integrated with systemd meaning that it logs everything that is happening on the server, and rsyslogs adds a few extra services to this. It takes care of writing log information to specific files, and allows for the configuration of remote logging and log services.

There is also an auditd service available. This service allows the admin to learn more about specific services and processes, as well as about users have been doing on the system. One service that logs information to the auditd service is SELinux, as an example. 

In order to learn more about what's happening on a system, an admin can use three different approaches:

- Using `journalctl` to get more information from the journal.
- Using the `systemctl status <unit>` command to get an overview of the most recent events that have been logged through systemd-journald.
- Monitoring the files that reside in `/var/log` which have been written by rsyslog.

## Log Files

Apart from the messages that can be read by `journalctl`, there are also the log files that can be found in `/var/log.` Most of the files here are created by rsyslog, but there are also some services that write their own logs to this directory. It's possible to read the logs here by using a pager utility like `less`. 

The total number of files in this directory will constantly change depending on the configuration of the server as well as the services that are running. There are some files, however, that are usually present in this directory, and it's a good idea to know which files these are. The following table provides an overview of the standard files that can be found in `/var/log`. 

| Log | Description |
| --- | --- |
| `/var/log/messages` | Most common log file and is a generic log file where messages are written to. |
| `/var/log/dmesg` | Contains log messages about the kernel. | 
| `/var/log/secure` | Contains messages related to authentication. A good place to find auth errors. |
| `/var/log/boot.log` | Messages related to the system startup. |
| `/var/log/audit/audit.log` | Contains audit messages, like those from SELinux. |
| `/var/log/mailbox` | Messages that are related to mail. |
| `/var/log/httpd/` | Log messages written by Apache. |

### Understanding Log Files

Let's say we use the following command: 

```sh
tail -10 /var/log/messages
```

This will output logging information about the system.

- Date and time: Every log will have a timestamp.
- Host: The host that the messages originated from.
- Service or process name and PID: The name of the service or process that generated the message.
- Content: The content of the message in question.

### Live Logging

One way to watch a log as it's being written to is by using the `tail -f <logfile` command, which shows in real time as lines are added to the file. The trace will remain open until we close `tail` with `Ctrl-C`. 

### Logger

The `logger` command enables users to write messages to rsyslog from the command line or from a script. Start by typing in `logger` followed by the message that needs to be written to the logs. It's also possible to choose the priority and the utility to log messages to. For instance, the command `logger -p kern.err hello` will write "hello" to the kernel facility, and will use the error priority.

## Systemd-journald

The journal is a binary file that is stored temporarily in the file `/run/log/journal`. It's possible to examine this file by using the `journalctl` command.

### `journalctl`

When using the `journalctl` command without arguments, it will show recent events that have been written to the journal since the server started. The result of this command is shown in the `less` pager, and by default it shows the beginning of the journal. In order to see the last messages that were logged, use the `journalctl -f` command instead, and use uppercase **G** in order to go to the end of the journal. 

One option is to use `journalctl -o verbose`, which provides detailed information about all items that have been logged, including the PID, ID of all associated users and group accounts, the associated commands, and more.

More arguments can be used with `journcalctl` For instance, including `-b` shows a boot log, including messages that were generated during the boot procedure. The `-x` option adds explanations to the information that is provided, making to interpret specific messages. Another option is the `-u` option, which allows the admin to view messages that were logged for a specific systemd unit, for instance, `journalctl -u sshd`. The following table contains information about the more commonly-used `journalctl` options:

| Option | Description |
| --- | --- |
| `-f` | Shows bottom of journal and adds new messages generated live |
| `-b` | Displays the boot log |
| `-x` | Adds additional explanations to the logged items |
| `-u` | Used to filter log messages for a specific unit |
| `-p` | Filters for messages with a specific priority |

By default, the journal is stored in `/run/log/journal`, and the entire `/run` directory is used for current process status information, meaning that it is cleared when the system reboots. In order to ensure that the journal persists across boots, it's worth creating the directory `/var/log/journal`. 

Along with this, it's also necessary to change the `Storage=auto` parameter in `/etc/systemd/journald.conf`, which is usually set by default. There are different values that can be assigned to this parameter:

- `Storage=auto`: The journal will write to disk only if `/var/log/journal` exists.
- `Storage=volatile`: The journal is stored only in the `/run/log/journal` directory.
- `Storage=persistent`: The journal is stored on the disk in the directory `/var/log/journal`. If the directory doesn't already exist, it will be created automatically.
- `Storage=none`: No data is stored, but it's possible to forward to other targets including the syslog or kernel buffer.

Even when there is a persistent write to the file in `/var/log/journal`, the logs will not remain forever because the journal as log rotation built in by default and is activated monthly. Along with this, the journal is limited to a maximum size of 10% of the size of the file system, and will not grow if there is less than 15% of the file system remaining. When this occurs, the oldest messages are automatically deleted in order to make room for new messages. It's easy enough to change the retention times by making modifications to the `/etc/systemd/journald.conf` file.

## rsyslogd

It's possible to configure the rsyslogd service by modifying the `/etc/rsyslog.conf` file, along with optional drop-in files in `/etc/rsyslog.d`. The `/etc/rsyslog.conf` file is where the main configuration is found, but it's not the only file where the config can be changed. For instance, further settings can be found in `/etc/rsyslog.d`.

The `rsyslog.conf` file is used to specify what is meant to be logged and where. There are different sections within this file, including:

- #### MODULES ####: Modules are included to increase the supported featureset for rsyslog.
- #### GLOBAL DIRECTIVES ####: Used to specify global parameters, such as the location where auxilliary files are written or the default timestamp format.
- #### RULES ####: The most important part of the rsyslog.conf file, containing the rules that define what kind of information should be logged to which file.

rsyslog makes use of facilities, priorities, and destinations when it comes to logging information:

- A **facility** defines the category of info that is being logged. rsyslog makes use of a fixed list of facilities, which are not able to be extended. This is due to the backward compatibility with the older syslog service.
- A **priority** is used to specify how severe a message is that's being logged. When specifying a priority, all messages with that priority and all higher priorities are logged.
- A **destination** is where the messages will be written. Usually the destination is a file, but rsyslog modules can be used as a destination as well, which allows further processing through a rsyslog module.

The following table contains rsyslog facilities. Worth keeping in mind that these cannot be changed.

| Facility | Description |
| --- | --- |
| auth\authpriv | Any messages that are related to authentication |
| cron | Any messages that are generated by the `cron` service |
| daemon | This is a generic facility that's used for nonspecific daemons |
| kern | Any kernel messages |
| lpr | Messages that are generated by the legacy lpd print system |
| mail | Messages that are related to email |
| mark | A facility that can be used to write a marker periodically |
| new | Any messages that are generated by the NNTP news system |


