---
date: 2026-06-07
tags:
  - 培训
  - KubeSphere
  - 产品知识
  - 多租户
  - 网络
  - DevOps
  - 服务网格
  - 商业逻辑
category: 产品知识库/青云/KubeSphere
---

# KubeSphere 培训材料知识归档（2026年4-5月期培训）

## 材料清单

| 序号 | 文件名 | 类型 | 期数 | 核心主题 |
|------|--------|------|------|---------|
| 1 | [2026-04-20 期培训-kubesphere 产品介绍+客户案例+商业逻辑.pptx](file:///Users/zhu/Downloads/2026-04-20%20%E6%9C%9F%E5%9F%B9%E8%AE%AD-kubesphere%20%E4%BA%A7%E5%93%81%E4%BB%8B%E7%BB%8D%2B%E5%AE%A2%E6%88%B7%E6%A1%88%E4%BE%8B%2B%E5%95%86%E4%B8%9A%E9%80%BB%E8%BE%91.pptx) | PPTX(56页) | 4月20日 | 产品介绍、客户案例、商业逻辑 |
| 2 | [2026-04-29期培训-多租户权限治理设计.html](file:///Users/zhu/Downloads/2026-04-29%E6%9C%9F%E5%9F%B9%E8%AE%AD-%E4%BB%8E%20Namespace%20%E5%88%B0%E4%BC%81%E4%B8%9A%E7%A9%BA%E9%97%B4%EF%BC%9AKubeSphere%20%E5%A4%9A%E7%A7%9F%E6%88%B7%E6%9D%83%E9%99%90%E6%B2%BB%E7%90%86%E8%AE%BE%E8%AE%A1.html) | HTML/PDF(14页) | 4月29日 | 多租户权限治理设计 |
| 3 | [2026-05-19 期培训-网络方案部分.pptx](file:///Users/zhu/Downloads/2026-05-19%20%E6%9C%9F%E5%9F%B9%E8%AE%AD-%E7%BD%91%E7%BB%9C%E6%96%B9%E6%A1%88%E9%83%A8%E5%88%86.pptx) | PPTX(17页) | 5月19日 | 容器网络方案 |
| 4 | [2026-05-19-服务、网关、服务网格.pdf](file:///Users/zhu/Downloads/2026-05-19-%E6%9C%8D%E5%8A%A1%E3%80%81%E7%BD%91%E5%85%B3%E3%80%81%E6%9C%8D%E5%8A%A1%E7%BD%91%E6%A0%BC.pdf) | PDF(5页) | 5月19日 | Service/Ingress/Gateway/服务网格 |
| 5 | [kubesphere devops cicd.pptx](file:///Users/zhu/Downloads/kubesphere%20devops%20cicd.pptx) | PPTX(14页) | — | DevOps CI/CD |

---

## 一、KubeSphere 产品核心知识（4月20日培训）

### 1.1 产品定位
KubeSphere 是构建在 Kubernetes 之上的**企业级分布式多租户容器平台**，定位为"面向云原生的分布式操作系统"。

### 1.2 核心价值主张
- 降低云原生使用门槛
- 统一管理多云/多集群
- 提升研发交付效率
- 安全合规、资源可计量

### 1.3 核心功能模块

| 模块 | 功能 | 售前话术要点 |
|------|------|-------------|
| 可视化集群管理 | 多集群统一管控、一键部署、弹性伸缩 | "一个面板管理所有集群" |
| 多租户权限控制 | 企业空间>项目/DevOps项目/集群，多层级预置角色 | "从Namespace到企业空间的治理升级" |
| DevOps应用交付 | CI/CD流水线、S2I/B2I、Argo CD持续部署 | "代码到生产，一条流水线" |
| 算力设备管理 | NVIDIA GPU/Ascend NPU等6种异构设备统一纳管 | "一平台纳管全部算力" |
| 可观测性 | 监控/日志/告警/网络可观测/链路追踪(OpenTelemetry) | "从黑盒到透明" |
| 集群巡检 | KubeEye自动化巡检 | "不等出问题，提前发现" |
| 应用商店 | OpenPitrix应用管理 | "一键部署企业应用" |
| AI助手 | AI诊断、问AI | "v4.2.1 新特性" |

### 1.4 商业逻辑
- **售卖计量单位：** CPU / vCPU
- **三种授权方式：**
  - 裸金属：按物理CPU计
  - 虚拟化：按vCPU计
  - CPU兑换vCPU：1 CPU = 40 vCPU

### 1.5 目标客户画像
- 中大型研发团队（50人+）
- 敏捷开发、快速迭代需求
- 当前使用传统VM或自建K8s+Jenkins
- 制造业、金融、政企等传统行业数字化转型

### 1.6 ISV合作伙伴模式
**1+N+X 战略合作模型：**
- 1：KubeSphere 底座
- N：扩展组件（DevOps、可观测、服务网格等）
- X：第三方业务平台集成

### 1.7 客户案例（售前可用）

| 客户 | 行业 | 场景 | 亮点 |
|------|------|------|------|
| 中移动金融科技（和包出行） | 金融科技 | 容器化解决弹性变更 | 大规模容器化 |
| 上海市规划和自然资源局 | 政府 | 一云多芯统一混合云容器平台(X86+ARM) | 信创+混合架构 |
| 山东港口科技集团 | 港口/物流 | OEM打包+带动5个客户 | 年均工单仅6个，稳定性高 |
| AI智算平台（未具名） | AI | GPU/NPU异构算力纳管 | v4.2.1 6种算力统一管理 |

---

## 二、多租户权限治理设计（4月29日培训）

> 适用版本：KubeSphere v4.2.1

### 2.1 核心结论
**K8s Namespace ≠ 多租户治理。** 企业空间不是多加一层概念，而是把原本分散在K8s里的资源、权限和配额，整理成企业更容易理解和落地的多租户管理模型。

### 2.2 K8s原生 vs KubeSphere 对比

| 原生K8s | 企业实际问题 | KubeSphere方案 |
|---------|-------------|---------------|
| Namespace | 不容易表达资源属于哪个团队/客户 | 企业空间承接团队/租户边界 |
| RBAC | 授权分散，维护复杂 | 平台/集群/空间/项目四层分层授权 |
| 多集群 | 每个集群单独分配，管理割裂 | 企业空间先授权集群，项目再落到集群 |
| ResourceQuota | 只能管单项目，团队总量不好控 | 企业空间配额+项目配额+默认容器配额 |
| 集群管理员 | 容易让所有事都依赖平台运维 | 平台/集群/空间/项目职责分离 |

### 2.3 典型落地场景
- **研发部 (ws-rd)：** 测试+生产集群，项目按环境拆分(dev/test/prod)
- **算法部 (ws-ai)：** 测试+GPU集群，项目按训练/服务拆分
- **交付团队 (ws-delivery)：** 仅授权客户集群，按客户拆分项目

### 2.4 五层架构
1. 企业身份源 → 统一登录入口
2. KubeSphere平台层 → 统一管理
3. 多集群资源池 → 计算/存储/网络
4. 企业空间 → 团队/租户边界
5. 项目Namespace → 应用/环境承载

### 2.5 四层角色授权
| 层级 | 角色 | 给谁 |
|------|------|------|
| 平台角色 | platform-admin/platform-user | 平台管理员 |
| 集群管理 | 集群运维 | 基础设施团队 |
| 企业空间 | workspace-admin/workspace-viewer | 团队负责人 |
| 项目角色 | project-admin/project-viewer/project-member | 开发/测试/运维 |

### 2.6 三层资源配额
1. **企业空间配额** — 限制团队在集群中的资源总量
2. **项目配额** — 限制单个项目的资源和对象数量
3. **默认容器配额** — 兜底机制，避免业务忘记配置request/limit

### 2.7 统一认证 ≠ 授权
- LDAP/OIDC/CAS/GitHub/阿里云IDaaS 只解决"用户是谁"
- KubeSphere角色解决"能访问什么资源、能做什么操作"
- 登录成功 ≠ 自动拥有资源权限

### 2.8 落地检查清单（6步）
1. 先划企业空间（部门/业务线/客户）
2. 再授权集群（只开放需要的）
3. 再建项目（按应用/环境）
4. 再分角色（分层授权）
5. 再设配额（三层配额）
6. 最后接入统一认证（身份+权限分离）

### 2.9 常见误区
- ❌ 有了Namespace就等于多租户治理 → ✅ 企业空间才贴近组织和租户边界
- ❌ 接入LDAP后用户自动有资源权限 → ✅ 外部认证只确认身份
- ❌ 为了省事直接给platform-admin → ✅ 权限过大，容易越权
- ❌ 只设项目配额就够了 → ✅ 需要三层配额配合
- ❌ 企业空间越细越安全 → ✅ 增加管理成本，按稳定边界划分

---

## 三、容器网络方案（5月19日培训）

### 3.1 业务访问全链路
**入口流量：** Client → F5 → LoadBalancer → Gateway Service → Ingress Gateway → 业务Pod
**东西向：** Console Pod → Server Service → Server Pod → MySQL Service → MySQL Pod

### 3.2 Calico CNI
- **Overlay模式：** IPIP隧道 / VXLAN隧道
- **Underlay模式：** 与交换机BGP Peer接入底层网络
- **IPPool：** 可绑定到特定Namespace

### 3.3 Kube-OVN CNI
- 基于OVN的SDN网络方案
- 支持子网、VPC、ACL、QoS等高级网络功能

### 3.4 Multus CNI（Meta插件）
- 依赖Main插件（Ipvlan/Macvlan/SR-IOV）
- 依赖IPAM插件（Whereabouts/Spiderpool）
- 实现多网卡绑定 → 管理/业务/存储三平面分离

### 3.5 NetworkPolicy
- 基于podSelector的ingress/egress规则
- 支持ipBlock（CIDR白名单/黑名单）
- namespaceSelector跨命名空间控制
- 端口级别精细控制

---

## 四、Service / 网关 / 服务网格（5月19日培训）

### 4.1 Service API
| 类型 | 用途 |
|------|------|
| ClusterIP | 集群内部访问 |
| NodePort | 节点端口暴露 |
| LoadBalancer | 外部LB接入 |
| ExternalName | DNS别名 |

### 4.2 Ingress API vs Gateway API
| 对比 | Ingress API | Gateway API |
|------|------------|-------------|
| 协议 | 仅HTTP/HTTPS | HTTP/gRPC/TLS/TCP |
| 职责边界 | 模糊（平台/应用混合） | 清晰（平台管Gateway，应用管Route） |
| 状态 | **已冻结，ingress-nginx退役** | 社区主推方向 |
| KubeSphere实现 | 基于ingress-nginx | 基于Traefik |

### 4.3 KubeSphere 网关体系
- **三级管理：** 集群网关 / 企业空间网关 / 项目网关
- **日志：** 实时+长期存储
- **监控：** RED指标（Rate/Error/Duration）

### 4.4 KubeSphere 服务网格（基于Istio）
**灰度发布三种模式：**
1. 蓝绿部署 — 新旧版本完整切换
2. 金丝雀发布 — 按比例逐步引流
3. 流量镜像 — 影子流量测试

**流量管理策略：**
- 负载均衡：随机/轮询/最少请求/一致性哈希
- 连接池管理
- 熔断器
- mTLS东西向加密

**可观测：** Kiali流量拓扑 + Jaeger链路追踪 + RED指标

---

## 五、DevOps CI/CD（培训材料）

### 5.1 流水线架构
- **代码管理：** GitLab（可部署于K8s集群内）
- **持续集成：** Jenkins / Tekton Pipeline
- **镜像仓库：** Harbor（漏洞扫描+镜像签名）
- **持续部署：** ArgoCD GitOps
- **灰度发布：** Istio金丝雀策略

### 5.2 DevOps扩展要点
- 跳过TLS认证配置
- 自定义镜像构建
- Containerd环境使用podman
- 节点标签管理
- 文档: KubeSphere v4.2.1 DevOps扩展 + Image Builder扩展

---

## 售前实战应用总结

| 客户场景 | 对应知识点 | 材料来源 |
|---------|-----------|---------|
| 振石集团K8s平台 | 商业逻辑(CPU/vCPU授权)、多租户治理、DevOps | 材料1+2+5 |
| 华孚时尚AI智算 | 算力设备管理(GPU/NPU)、多租户、企业空间 | 材料1+2 |
| 制造业售前 | 客户案例(港口/金融)、商业逻辑、ISV模式 | 材料1 |
| 网络方案设计 | Calico/Kube-OVN/Multus/NetworkPolicy/三平面 | 材料3+4 |
| 服务暴露与灰度 | Service/Ingress/Gateway API/Istio金丝雀 | 材料4 |
