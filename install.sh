#!/bin/bash
# One-shot installer: local Azure (Azurite) + azlocal helper on any Linux box with node+npm
set -e
npm install -g azurite
mkdir -p ~/azurite-data ~/bin
cp "$(dirname "$0")/bin/azlocal" ~/bin/azlocal && chmod +x ~/bin/azlocal
(crontab -l 2>/dev/null | grep -v azlocal; echo "@reboot $HOME/bin/azlocal start"; echo "*/10 * * * * $HOME/bin/azlocal start >/dev/null 2>&1") | crontab -
~/bin/azlocal start && ~/bin/azlocal test
echo "DONE - use: azlocal start|stop|status|test|env|up <file>|ls"
