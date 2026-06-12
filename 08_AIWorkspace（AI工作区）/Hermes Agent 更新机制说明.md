
# Hermes Agent 更新机制说明

> 更新时间：2026-06-05 | 基于源码 `hermes_cli/main.py`

---

## 一、概述

Hermes Agent 提供四层更新机制：

| 层级 | 触发方式 | 说明 |
|------|---------|------|
| 1 | 启动时后台检查 | 每次 `hermes` 启动时静默检测，缓存6小时 |
| 2 | `hermes update` | 完整命令行更新流程 |
| 3 | `/update` 会话命令 | CLI/TUI 中触发更新并自动重启 |
| 4 | Gateway `/update` | 消息平台（微信等）中触发，流式输出 |

---

## 二、安装方式检测

更新策略取决于安装方式（`hermes_cli/config.py::detect_install_method`）：

| 安装方式 | 更新命令 | 特征 |
|---------|---------|------|
| **Git** | `hermes update` | `.git` 目录存在 |
| **pip** | `uv pip install --upgrade` | PyPI 包安装 |
| **Homebrew** | `brew upgrade hermes-agent` | 托管安装，禁止自更新 |
| **NixOS** | `nixos-rebuild switch` | 托管安装，禁止自更新 |
| **Docker** | `docker pull` | 容器环境 |

---

## 三、Git 模式完整更新流程

```
hermes update
├─ SIGHUP 保护（防止终端断开）
├─ 更新前备份 → ~/.hermes/backups/pre-update-*.zip
├─ git fetch origin
├─ 检测当前分支 → 切换到 main（自动 stash 本地修改）
├─ git rev-list --count HEAD..origin/main
│   ├─ 0 → "Already up to date" → 恢复分支+stash
│   └─ N → 继续
├─ 创建状态快照（state.db/config/pairing）
├─ git pull --ff-only origin main
│   └─ 失败？→ git reset --hard origin/main
├─ 恢复 stash（用户可选）
├─ 清除 __pycache__（防止 ImportError）
├─ 更新 Python 依赖（uv 或 pip）
├─ 更新 Node 依赖 + 构建 Web UI
├─ 同步 Skills（所有 Profile）
├─ 配置迁移检查（缺失字段/env/版本）
└─ 完成
```

---

## 四、Gateway 更新（微信等平台）

用户发送 `/update` → Gateway 后台执行：

1. 写入 `~/.hermes/.update_pending.json`（记录来源）
2. `setsid bash -c "hermes update --gateway"` 完全脱离
3. 监控线程每2秒轮询输出文件
4. 每4秒批量推送更新日志到消息平台
5. 检测交互提示 → 转发按钮或文本
6. 完成后发送 ✅/❌ 并清理临时文件

---

## 五、配置文件

```yaml
# ~/.hermes/config.yaml
updates:
  pre_update_backup: false    # 更新前自动备份（默认关闭）
```

缓存文件：
- `~/.hermes/.update_check` — 版本检查缓存（6小时）
- `~/.hermes/.update_pending.json` — Gateway 更新标记

---

## 六、故障恢复

| 场景 | 恢复方案 |
|------|---------|
| 更新中断 | pre-update backup + state snapshot 可恢复 |
| 更新后异常 | `hermes import ~/.hermes/backups/pre-update-*.zip` |
| 代码损坏 | `cd ~/.hermes/hermes-agent && git reset --hard HEAD~1` |

> 完整文档：`/Users/zhu/hermes-agent/更新机制说明.md`
