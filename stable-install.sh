#!/bin/bash

# ログファイル
log=/var/log/stable-install/$(date '+%Y%m%d-%H%M%S').log

echo "ログファイルを作成します"
touch $(log)