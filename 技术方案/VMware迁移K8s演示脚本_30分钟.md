---
topic: 客户演示脚本
scenario: VMware 虚拟机迁移到 Kubernetes
duration: 30分钟
tool: KubeVirt + KubeSphere
date: 2026-07-06
---

# VMware → K8s 虚拟机迁移客户演示脚本 (30分钟)

## 演示结构

| 幕 | 内容 | 时间 |
|----|------|------|
| 第一幕 | 开场 — 为什么关注这件事 | 3min |
| 第二幕 | 环境展示 — 让客户看到"真的在跑" | 3min |
| 第三幕 | 演示1 — 从零创建一个 VM | 5min |
| 第四幕 | 演示2 — VM 热迁移（Live Migration） | 5min |
| 第五幕 | 演示3 — VMware VM 迁移到 KubeVirt | 7min |
| 第六幕 | KubeSphere 统一管理展示 | 4min |
| 第七幕 | 总结 + Q&A | 3min |

## 核心话术

开场：直接点痛点（Broadcom涨价/信创/国产化），不讲PPT直接看效果。

热迁移："VMware vMotion 在K8s里也能做到，而且不需要共享存储。"

迁移："CDI转磁盘 + Forklift批量编排，分钟级完成切换。"

管理："VM 和容器在同一个页面管，不用切工具。"

总结："先迁移过来，再逐步容器化，风险最低。"

## 应急预案

- 网络不稳：提前下载镜像到本地
- Live Migration失败：切换录屏视频+口述原理
- GPU迁移问题：实话说当前不支持，行业都一样
- 任何kubectl命令失败：切到KubeSphere图形界面操作

## 输出文件

- [VMware迁移K8s演示脚本_30分钟.docx](file:///Users/zhu/Desktop/VMware迁移K8s演示脚本_30分钟.docx)
