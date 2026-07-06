---
topic: KubeVirt 迁移能力
source: KubeVirt 官方 YouTube 频道 (@KubeVirt)
type: 技术研究报告
date: 2026-07-06
---

# KubeVirt 官方 YouTube 频道迁移能力研究报告

## 频道概况

- 频道：https://www.youtube.com/@KubeVirt
- 视频数：658 个
- 订阅者：1570
- 跨度：2019 — 2026

## 核心迁移视频清单

### 直接相关

| 视频 | 时长 | 播放量 | 年份 |
|------|------|--------|------|
| FOSDEM 2026: Cross-Cluster Live Migration and Storage Live Migration | 25min | 23 | 2026 |
| Automated Migration of VMs from VMware or Openstack to KubeVirt | 32:59 | 2511 | 2021 |
| Migrate an existing Windows VM workload to Kubernetes using KubeVirt and CDI | ~8min | 1842 | 2019 |
| Moving oVirt and VMware VMs to KubeVirt with VM Import Operator and Forklift | ~30min | 1635 | 2020 |
| Summit 2022: Live Migration Policies | 42min | 144 | 2022 |
| Kubevirt Live migration and SRIOV | 19min | 1067 | 2020 |

### 相关

| 视频 | 播放量 | 年份 |
|------|--------|------|
| Harvester: OSS HCI built on K8s and KubeVirt | 3190 | 2020 |
| KubeVirt pxe boot demo | 2553 | 2018 |
| The latest in KubeVirt VM exports | 299 | 2023 |
| Introduction And Kubevirt History | 392 | 2021 |
| FOSDEM 2026: EVPN overlays for multi-cluster KubeVirt | 39 | 2026 |

## 四项核心发现

1. **KubeVirt 内部可实现零停机热迁移**（节点间 VM Live Migration），支持 SR-IOV
2. **VMware → KubeVirt 仍需停机切换**（先同步再停源再切），中断分钟级
3. **成熟工具链**：CDI + VM Import Operator + Forklift 已生产可用
4. **2026 年新方向**：跨集群热迁移 + 存储热迁移，追平 vMotion 能力

## 与青云/KubeSphere 的结合

- KubeVirt 负责 VM 运行和迁移能力
- KubeSphere 负责统一管理控制台
- Harvester 提供完整 VMware 替代方案

## 输出文件

- [KubeVirt迁移能力研究报告.docx](file:///Users/zhu/Desktop/KubeVirt迁移能力研究报告.docx)
