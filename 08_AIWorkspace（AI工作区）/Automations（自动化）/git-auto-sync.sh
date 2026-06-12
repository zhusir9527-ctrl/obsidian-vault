#!/bin/bash
# 自动同步 Obsidian 笔记库到 GitHub
cd ~/obsidian-vault || exit 1

# 拉取最新变更（自动 rebase）
git pull --rebase 2>/dev/null

# 提交本地变更
if ! git diff --quiet; then
    git add -A
    git commit -m "auto: sync from Hermes Agent [$(date +%Y-%m-%d_%H:%M)]"
fi

# 推送
git push 2>/dev/null

echo "[$(date +%Y-%m-%d_%H:%M:%S)] Sync completed"
