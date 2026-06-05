
---
tags:
  - kubernetes
  - k8s
  - 容器编排
  - 云原生
  - 基础知识
created: 2026-06-04
aliases:
  - K8s核心概念
  - Kubernetes基础
---

# Kubernetes 核心概念

## 一、概述

Kubernetes（简称 K8s）是 Google 开源的容器编排平台，用于自动化部署、扩展和管理容器化应用。2015 年发布 1.0 版本，现已成为云原生计算基金会（CNCF）的旗舰项目，是云原生生态的事实标准。

## 二、Kubernetes 架构

### 2.1 架构概览

Kubernetes 采用 **主从架构（Master-Node）**，控制面负责全局决策和调度，工作节点负责运行实际工作负载。

- **控制平面（Control Plane）**：管理集群状态、调度 Pod、响应集群事件
- **工作节点（Worker Node）**：运行容器化应用，执行控制平面下发的任务

### 2.2 控制平面组件

| 组件 | 功能 |
|------|------|
| **kube-apiserver** | 集群统一入口，提供 REST API；所有组件通过 API Server 通信 |
| **etcd** | 分布式键值存储，保存集群所有配置数据和状态信息 |
| **kube-scheduler** | 负责 Pod 调度，将新建 Pod 分配到合适的 Node 上 |
| **kube-controller-manager** | 运行各种控制器（Node、Replication、Endpoint 等），维持集群期望状态 |
| **cloud-controller-manager** | 与云服务商 API 交互，管理云平台特定资源（负载均衡、存储等） |

### 2.3 工作节点组件

| 组件 | 功能 |
|------|------|
| **kubelet** | Node 上的核心代理，确保 Pod 按预期运行，与 API Server 通信 |
| **kube-proxy** | 网络代理，实现 Service 的网络转发和负载均衡规则 |
| **容器运行时（Container Runtime）** | 负责运行容器，支持 Docker、containerd、CRI-O 等 |

## 三、核心资源对象

### 3.1 Pod — 最小调度单元

**Pod** 是 Kubernetes 中创建和管理的最小可部署单元。

- 一个 Pod 包含一个或多个紧密耦合的容器
- 同一 Pod 内的容器共享：
  - **网络命名空间**：共享 IP 地址和端口空间（通过 localhost 通信）
  - **存储卷（Volume）**：共享挂载的存储
  - **IPC 命名空间**：进程间通信
- Pod 是**临时性**的，可被创建、删除、重建

使用场景：
- **单容器 Pod**：最常见模式，一个 Pod 只运行一个容器
- **多容器 Pod**：Sidecar 模式（日志收集、代理）、Init 容器（初始化任务）

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx-pod
  labels:
    app: nginx
spec:
  containers:
  - name: nginx
    image: nginx:1.24
    ports:
    - containerPort: 80
```

### 3.2 Deployment — 无状态应用管理

**Deployment** 为 Pod 和 ReplicaSet 提供声明式更新能力，是管理无状态应用的标准方式。

核心能力：
- **声明式部署**：描述期望状态，控制器自动调和至目标状态
- **滚动更新（Rolling Update）**：逐步替换旧版本 Pod，保证服务不中断
- **回滚（Rollback）**：快速回退到历史版本
- **副本管理**：自动维护指定数量的 Pod 副本
- **暂停/恢复**：支持金丝雀发布（Canary Deployment）

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:1.24
        ports:
        - containerPort: 80
```

### 3.3 Service — 服务发现与负载均衡

**Service** 为一组 Pod 提供稳定的网络访问入口（虚拟 IP）。

Pod 的 IP 是动态变化的，Service 通过标签选择器（Label Selector）将请求转发到匹配的 Pod。

Service 类型（Type）：
- **ClusterIP**（默认）：集群内部 IP，仅集群内访问
- **NodePort**：在每个 Node 上开放固定端口（30000-32767），外部可访问
- **LoadBalancer**：使用云服务商的负载均衡器暴露服务
- **ExternalName**：通过 DNS CNAME 将服务映射到外部地址

### 3.4 其他核心资源

| 资源 | 用途 |
|------|------|
| **ReplicaSet** | 维护指定数量的 Pod 副本（通常由 Deployment 管理） |
| **StatefulSet** | 管理有状态应用（数据库等），提供稳定的网络标识和持久存储 |
| **DaemonSet** | 确保每个 Node 运行一个 Pod 副本（日志收集、监控代理） |
| **Job / CronJob** | 一次性任务 / 定时任务 |
| **ConfigMap** | 非敏感配置数据的存储（环境变量、配置文件等） |
| **Secret** | 敏感信息存储（密码、Token、密钥等），Base64 编码 |
| **Namespace** | 虚拟集群，用于资源隔离和多租户场景 |
| **Ingress** | 管理集群外部 HTTP/HTTPS 路由，七层负载均衡 |
| **PersistentVolume (PV) / PersistentVolumeClaim (PVC)** | 持久化存储抽象，解耦存储供给与消费 |

## 四、核心技术机制

### 4.1 Label 和 Selector

- **Label**：键值对标签，附加在对象上，用于标识和分组
- **Selector**：通过标签筛选对象，是 Service、Deployment 与 Pod 之间的关联纽带

### 4.2 声明式 API 与控制器模式

Kubernetes 采用**声明式 API** 设计：

1. 用户声明资源的**期望状态**（Desired State）
2. 控制器持续监控**实际状态**（Actual State）
3. 控制器自动调和（Reconcile），使实际状态趋近期望状态

### 4.3 网络模型

Kubernetes 网络遵循以下原则：
- 每个 Pod 拥有独立的 IP 地址
- Pod 间无需 NAT 即可通信
- Node 上的 Agent 可与同 Node 的 Pod 通信

常见 CNI（容器网络接口）插件：
- **Flannel**：简单 overlay 网络
- **Calico**：基于 BGP 的高性能网络，支持网络策略
- **Cilium**：基于 eBPF，高性能，支持服务网格

### 4.4 调度机制

kube-scheduler 通过**过滤（Filtering）**和**打分（Scoring）**两个阶段选择最佳 Node：

1. **过滤阶段**：排除不满足条件的 Node（资源不足、污点不匹配等）
2. **打分阶段**：对剩余 Node 打分，选择最优（亲和性、资源均衡等）

## 五、信息来源

- [Kubernetes 官方文档](https://kubernetes.io/zh-cn/docs/concepts/)
- [CNCF - Cloud Native Computing Foundation](https://www.cncf.io/)
- [Kubernetes 架构详解 - Google Cloud](https://cloud.google.com/kubernetes-engine/docs/concepts/kubernetes-architecture)
- [《Kubernetes in Action》](https://www.manning.com/books/kubernetes-in-action) - Marko Luksa
- [《深入剖析 Kubernetes》](https://book.douban.com/subject/35583629/) - 张磊
