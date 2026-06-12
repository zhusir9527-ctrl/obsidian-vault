#!/bin/bash
# 自动同步 Obsidian 笔记库到 GitHub
cd ~/obsidian-vault || exit 1

# 拉取最新变更
git pull --ff-only 2>/dev/null

# 提交本地变更
if ! git diff --quiet; then
    git add -A
    git commit -m "auto: sync from Hermes Agent [$(date +%Y-%m-%d_%H:%M)]"
    git push
fi
