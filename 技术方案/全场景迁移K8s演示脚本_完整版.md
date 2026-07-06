---
topic: 客户演示脚本
scenario: 全场景虚拟机迁移到 Kubernetes
sources: VMware / 物理机 / 云平台（阿里云、华为云、腾讯云、AWS）
duration: 45分钟
tool: KubeVirt + CDI + qemu-img + KubeSphere
date: 2026-07-06
---

# 全场景虚拟机迁移到 Kubernetes 演示脚本（完整版）

## 与之前版本的差异

上一版只覆盖了 VMware → KubeVirt 和 KubeVirt 内部 Live Migration。本版新增：
- **物理服务器 → KubeVirt**（dd 全盘镜像 + CDI 导入）
- **云平台 → KubeVirt**（阿里云/华为云/腾讯云/AWS 导出 + qemu-img 转换 + CDI 导入）

## 三种来源的共同路径

不管来源是什么，核心路径统一：
> 导出系统盘镜像 → CDI 转换导入为 PVC → KubeVirt 启动 VM

源头差异只影响第一步（导出方式），后面的转换和导入流程完全相同。

## 演示结构（45 分钟共六幕）

| 幕 | 内容 | 时间 |
|----|------|------|
| 1 | 开场：三种来源，一条路径 | 5min |
| 2 | VMware → KubeVirt（CDI + Forklift） | 10min |
| 3 | 物理机 → KubeVirt（dd + CDI） | 10min |
| 4 | 云平台 → KubeVirt（导出 + qemu-img + CDI） | 10min |
| 5 | 三种来源对比 + KubeSphere 统一管理 | 7min |
| 6 | 总结 + PoC 建议 | 3min |

## 关键发现

- 物理机迁移：必须停机，dd 全盘镜像时间取决于磁盘容量。Windows 需额外注入 VirtIO 驱动
- 云平台迁移：各平台导出 API 不同（阿里云 OSS / 华为云 OBS / AWS S3），但最终都是标准磁盘镜像
- 三者的 CDI 导入部分完全相同
- 如需热同步（减少停机窗口），可叠加英方 i2Move Agent

## 输出文件

- [全场景迁移K8s演示脚本_完整版.docx](file:///Users/zhu/Desktop/全场景迁移K8s演示脚本_完整版.docx)
