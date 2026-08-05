## System Logging

There are three different systems in place that log all of the information on a Linux server. These include the following:

- Systemd-journald: This service is a part of systemd, and it's possible for admins to read system information using commands like `systemctl status` and `journalctl`. Systemd-journald had become the default logging service for most modern distros.
- Direct write: Some services will write information directly to log files, even some important services like Apache. This kind of logging is not typically recommended.
- rsyslogd: rsyslogd is an improved version of syslog, which is a service that takes care of managing all centralised logging activities. syslogd has been around for a long time, and while most default logging is done by systemd-journald, there are some things that it's not able to do, and this is where syslogd comes into play.

## Systemd-journald and rsyslogd


