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

The `logger` command enables users to write messages to rsyslog from the command line or from a script. Start by typing in `logger` followed by the message that needs to be written to the logs. 
