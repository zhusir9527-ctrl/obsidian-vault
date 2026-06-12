---
tags: [KubeSphere, 一体机, 规格, NeonSAN, 硬件]
created: 2026-06-10
source: ~/Desktop/青云网盘镜像/KSE/云原生一体机规格说明书.docx
---

# KubeSphere 容器一体机 规格说明书（学习笔记）

> 源文件：[云原生一体机规格说明书.docx](file:///Users/zhu/Desktop/青云网盘镜像/KSE/云原生一体机规格说明书.docx)

## 产品规格

| 型号 | KF3000 | KF3100 |
|------|--------|--------|
| CPU | 2×Xeon Silver 4214R (12C/2.4GHz) | 2×Xeon Silver 5218R (20C/2.1GHz) |
| 内存 | 4×32GB DDR4 (128GB) | 8×32GB DDR4 (256GB) |
| OS盘 | 2×480GB SSD RAID1 | 2×480GB SSD RAID1 |
| 存储 | 2×3.84TB NVMe SSD | 2×3.84TB NVMe SSD |
| 网络 | 2×25GbE SFP+ / 4×1GbE RJ45 | 2×25GbE SFP+ / 4×1GbE RJ45 |
| KSE授权 | 24 Core | 40 Core |
| NeonSAN | 8TB全闪 | 8TB全闪 |
| 服务 | 硬件36月+软件12月升级 | 同 |

## 一体机卖点

- 降低50%实施交付周期
- 降低30%整体运维成本
- 开箱即用

## KubeSphere 功能特性（摘要）

| 模块 | 功能 |
|------|------|
| 工作负载 | Deploy/StatefulSet/DaemonSet/Job/CronJob/Serverless + HPA |
| 镜像管理 | 仓库管理+镜像安全扫描+高可用 |
| 监控告警 | Prometheus多维度，节点/工作负载/Pod/容器全覆盖，邮件/微信/Slack |
| 日志 | 多租户统一日志，关键字/项目/应用名搜索 |
| 多集群 | 统一纳管已有K8s，跨集群应用部署 |
| CI/CD | 可视流水线+代码安全扫描+S2I/B2I |
| 微服务 | Istio内置，灰度/熔断/限流/智能路由 |
| 应用管理 | OpenPitrix全生命周期 |
| 边缘 | KubeEdge节点纳管+日志监控采集 |
| 计量计费 | 租户级资源用量+费用报表+大屏展示 |
| 审计 | 操作记录+API日志 |

## NeonSAN 存储底座

- RDMA网络，亚毫秒延迟，数百万IOPS
- 瞬时快照（单卷256个）+卷克隆（1:2048）
- 远程同步/异步复制（RPO=0金融级）
- 数据加密压缩（最大64:1）
- 多云平台支持（QingCloud/VMware/OpenStack/Hyper-V）

---

## 关联

- 销售手册：[[2026-06-10_KubeSphere销售参考手册_学习笔记]]
