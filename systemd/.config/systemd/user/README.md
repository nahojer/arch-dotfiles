# User modules

Run:

```bash
systemctl --user daemon-reload
systemctl --user enable --now alert-battery.timer

# Optionally check that the timer is active
systemctl --user list-timers
```
