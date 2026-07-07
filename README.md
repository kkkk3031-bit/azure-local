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

## Connect from ANY other machine (WSL / laptop / Termux) — tunnel mode
Azure stays on the VPS; your local `az` talks to it like it's real Azure. Nothing changes but the tunnel:
```bash
# 1. open the tunnel (keep this terminal open)
ssh -L 10000:localhost:10000 -L 10001:localhost:10001 -L 10002:localhost:10002 root@72.60.89.132

# 2. in a second terminal on your local machine:
export AZURE_STORAGE_CONNECTION_STRING="DefaultEndpointsProtocol=http;AccountName=devstoreaccount1;AccountKey=Eby8vdM02xNOcqFlqUwJPLlmEtlCDXJ1OUzFT50uSRZ6IFsuFq2UVErCz4I6tq/K1SZFPTOtr/KBHBeksoGMGw==;BlobEndpoint=http://127.0.0.1:10000/devstoreaccount1;QueueEndpoint=http://127.0.0.1:10001/devstoreaccount1;TableEndpoint=http://127.0.0.1:10002/devstoreaccount1;"
az storage container list -o table   # ← hits the VPS through the tunnel
```
Also included: `bin/logs-live` (realtime console) and `bin/logwatch-ai` (cron AI auto-fix from logs).
