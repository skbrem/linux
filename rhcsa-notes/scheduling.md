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


