---
tags: [QingCloud, Product, KubeSphere, 容器, Kubernetes, 云原生]
created: 2026-06-04
parent: "02_Products（产品知识库）/QingCloud（青云）"
---

# KubeSphere 容器平台概览

## 产品定位

KubeSphere 是青云科技旗下以 Kubernetes 为内核的**云原生分布式操作系统**，愿景是打造一个面向云原生应用的容器混合云平台。它是在 Kubernetes 之上构建的**以应用为中心的多租户容器平台**，提供全栈 IT 自动化运维能力，简化企业 DevOps 工作流。

KubeSphere 提供两个版本：
- **KubeSphere 开源社区版**：永久免费，零成本使用企业级功能
- **KubeSphere 企业版**：功能强大、服务完善、大量行业实践验证的企业级商用容器平台

## 核心功能

### 1. Kubernetes 多集群管理
- 跨多云与多集群统一分发应用
- 提供集群高可用与灾备的最佳实践
- 支持跨集群的可观测性
- 联邦集群应用管理

### 2. 多租户与权限管理
- 平台内置多租户设计（企业空间 → 项目 → 资源层级）
- 不同团队在统一平台中安全隔离
- 细粒度用户和角色管理（平台角色、企业空间角色）

### 3. 云原生可观测性
- 多维度与多租户的监控、日志、事件、审计搜索
- 多种告警策略与通知渠道（邮件、钉钉、飞书、企业微信）
- 支持日志转发
- 图形化操作面板与命令终端

### 4. DevOps 工作流
- 基于 Jenkins 引擎的 CI/CD
- 内置 Source-to-Image (S2I) 和 Binary-to-Image (B2I) 自动化打包部署工具
- 图形编辑面板创建流水线
- 支持 Jenkinsfile 方式创建流水线

### 5. 应用生命周期管理
- 应用商店一键部署与升级应用
- 支持导入 Helm 应用仓库可视化编辑与部署
- 应用模板管理
- 灰度发布、流量管理、网络拓扑与追踪

### 6. 扩展组件体系（v4 新特性）
- 安装并使用扩展组件
- 管理/升级/卸载扩展组件
- 可插拔架构，无缝集成主流开源工具

### 7. 企业版增强
- KubeSphere DMP：企业级云原生数据库管理平台
- 边缘计算平台：更开放、更易用、更智能
- 容器一体机：内置 KubeSphere 企业版，软硬件一体化
- KubeSphere 应用商店管理
- KubeSphere 服务网格

## 技术架构

### KubeSphere LuBan 架构（v4.0+）

KubeSphere v4 基于全新的云原生可扩展开放架构——**KubeSphere LuBan** 打造，于 2024 年 10 月正式发布。

**架构层次：**
```
Front End（前端）
  └── KubeSphere Console（控制台）

Back End（后端 REST API）
  ├── KubeSphere System API Server
  └── Controller Manager
```

**核心特点：**
- 前后端分离架构
- 基于可插拔架构，像搭积木一样按需扩展平台能力
- 支持第三方应用与云原生生态组件即插即用（plug-and-play）集成
- 支持云原生应用在多云与多集群的统一分发和运维管理

### 开源项目生态

| 项目 | 说明 |
|------|------|
| **KubeKey** | 极速安装与运维工具，加速 Kubernetes 部署，适配多环境，自动化全生命周期管理 |
| **OpenELB** | 原生负载均衡解决方案，填补裸金属 LB 空白，支持多网络模式 |
| **KubeEye** | Kubernetes 集群检测与诊断工具，发现配置风险与合规问题 |
| **Fluent Operator** | 云原生日志与数据采集引擎，统一日志采集与处理（已捐献） |
| **OpenFunction** | 云原生开源 FaaS（函数即服务）框架 |
| **Notification-Manager** | 多租户 Kubernetes 环境消息通知管理，支持邮件、钉钉、飞书、企业微信 |
| **Kube Design** | KubeSphere 控制台 React 组件库 |
| **Whizard** | Thanos 企业级发行版，Prometheus 长期存储方案 |

### 版本演进

| 版本 | 发布日期 | 关键更新 |
|------|----------|----------|
| v4.2.1 | 2026-01 | 功能优化和升级，提升安全性与稳定性 |
| v4.1.3 | 2025-03 | 多项功能优化和缺陷修复，提升安全性与易用性 |
| v4.1.2 | - | 补丁版本 |
| v4.1.1 | - | 首批 v4.1 系列 |
| v4.0 | 2024-10 | 全新 LuBan 架构，开源发布 |
| v3.4.1 | 2023-11 | 支持 K8s v1.26 |
| v3.3.2 | 2023-02 | DevOps 和应用商店易用性提升 |

## 竞争优势

1. **永久免费社区版**：零成本无忧使用，持续迭代企业级功能
2. **简易安装**：支持任何基础设施环境，在线与离线安装，一键升级与扩容集群
3. **功能丰富**：多租户、多集群、可观测性、DevOps 一体化
4. **灵活扩展**：基于可插拔 LuBan 架构，按需扩展
5. **开源初心**：自诞生始终坚持开源，深度参与全球云原生社区
6. **广泛生态**：与 Grafana、Loki、Higress 等深度协同
7. **全球影响力**：已有来自全球的大量知名企业与组织在生产环境中使用
8. **中国市场优势**：青云科技本土化支持，信创适配
9. **AI 集成**：2026 年 4 月发布 KubeSphere Skills，覆盖核心平台、DevOps、可观测性三大领域的 16 个技能包
10. **MCP Server**：2025 年 5 月发布，实现 AI 助手与 KubeSphere 无缝集成

## 适用场景

- **Kubernetes 多集群管理**：跨多云与多集群统一应用分发
- **一站式 DevOps 工作流**：整合 CI/CD 工具，简化交付流程
- **微服务架构**：在 Kubernetes 上运行和管理微服务
- **云原生可观测性**：多维度监控、日志、告警
- **多团队协作**：多租户隔离，基础设施团队、开发者、运维团队协同
- **边缘计算**：从云端到边缘部署云原生应用
- **企业级容器化转型**：VMware 替代、传统应用容器化

## 信息来源

- KubeSphere 官方网站：https://kubesphere.io/zh/
- KubeSphere 文档中心：https://kubesphere.io/zh/docs/v4.1/
- 青云科技官网：https://www.qingcloud.com/
- KubeSphere 开源社区 GitHub：https://github.com/kubesphere
- KubeSphere v4 LuBan 发布公告（2024-10-10）
- KubeSphere v4.2.1 发布公告（2026-01-12）
- KubeSphere v4.1.3 发布公告（2025-03-26）
- KubeSphere MCP Server 发布（2025-05-06）
- KubeSphere Skills 发布（2026-04-03）
