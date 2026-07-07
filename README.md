# azure-local — free local Azure (Azurite) setup

Local Azure storage emulator (blob/queue/table) + `azlocal` helper CLI. No subscription needed.

## Install anywhere
```bash
git clone git@github.com:khaledq84ever/azure-local.git && ./azure-local/install.sh
```

## Commands
- `azlocal start|stop|status` — control the emulator (127.0.0.1:10000-10002)
- `azlocal test` — end-to-end check
- `azlocal up <file>` / `azlocal ls` — quick blob upload/list
- `eval $(azlocal env)` then any `az storage ...` command

Data lives in `~/azurite-data`. Cron @reboot + 10-min watchdog keep it alive.
Set up 2026-07-07 on Hostinger VPS. AZ-400 practice scripts in `scripts/`.
