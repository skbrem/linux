systemctl cheat sheet

| Command | Description |
| --- | --- |
| `systemctl list-units --type=services` | List all services |
| `systemctl list-units --type=services --state=active` | List active services (both running and active) |
| `systemctl list-units --type=service --state=running` | List running services |
| `systemctl list-unit-files --type=service --state=enabled` | List enabled services |
| `systemctl status sshd` | Check specific service |
| `systemctl list-units --failed` | List failed units |
| `systemctl list-units --failed --type=service` | List failed services |
| `sudo systemctl status nginx.service` | Describe why specific service failed |
