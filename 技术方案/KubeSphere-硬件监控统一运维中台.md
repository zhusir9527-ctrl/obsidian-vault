---
topic: 统一运维中台
components: KubeSphere + Prometheus Exporters + 基调听云
type: 方案设计
date: 2026-07-06
---

# KubeSphere + 硬件监控 = 统一运维中台

## 核心卖点

KubeSphere 自带 Prometheus，把硬件 Exporter 接进去，就能在一套平台上同时看到「交换机端口断了 → 上面跑的 Pod 受影响没 → 业务接口有没有变慢」，三层打通，不用切工具。

---

## 一、KubeSphere 已有的能力（不用额外买）

| 组件 | 说明 |
|------|------|
| Prometheus（内置） | 采集 K8s 集群指标 + 节点指标 |
| Prometheus Operator | 管理 Prometheus 实例和采集配置 |
| AlertManager（内置） | 告警规则管理和路由 |
| 集群监控面板 | 节点、Pod、容器资源使用 |
| 自定义监控 | 可导入自定义 PromQL 仪表板 |
| 告警中心 | 统一告警查看和处理 |
| 日志查询 | 容器日志检索 |

不需要额外部署 Prometheus 和 Grafana，KubeSphere 本身就是监控平台。

---

## 二、加上硬件 Exporter 后的效果

### 2.1 统一监控面板 —— 一个页面看三层

```
┌─────────────────────────────────────────────┐
│          KubeSphere 集群监控大屏              │
├─────────────────────────────────────────────┤
│  ┌──────硬件健康──────┐ ┌────容器资源──────┐  │
│  │ 服务器温度：62°C   │ │ Pod CPU：45%    │  │
│  │ 风扇转速：8400RPM │ │ 内存：12/32G    │  │
│  │ 电源状态：正常     │ │ 磁盘IO：正常    │  │
│  │ RAID状态：Healthy │ │ 网络：1.2Gbps  │  │
│  │ ⚠️ 交换机端口3 down│ │ 重启次数：0    │  │
│  └───────────────────┘ └─────────────────┘  │
│  ┌──────────────────────────────────────┐    │
│  │       应用性能（对接听云APM）          │    │
│  │  慢SQL：3个 | 错误率：0.2% | P99：210ms│    │
│  └──────────────────────────────────────┘    │
└─────────────────────────────────────────────┘
```

### 2.2 告警联动 —— 一条链路串起来

传统痛点：交换机端口断了 → 运维凌晨被叫醒 → 手动查影响了哪些服务器 → 再看上面哪些容器 → 找到业务负责人。

KubeSphere 统一告警链：

```
snmp_exporter 发现端口 down
       │
       ▼
Prometheus 触发告警
       │
       ▼
AlertManager 查关联标签
  ├── 该交换机下连的服务器是 node-5、node-7
  ├── node-5 上跑了 order-service 的 3 个 Pod
  └── node-7 上跑了 payment-service 的 2 个 Pod
       │
       ▼
一条告警同时通知：
  ├── 网络运维：「交换机 10.0.254.1 端口 3 down」
  ├── 平台运维：「node-5/node-7 即将失联，Pod 准备迁移」
  └── 业务负责人：「order-service 可能有影响，请注意」
```

### 2.3 自定义硬件仪表板

在 KubeSphere 控制台直接创建硬件监控面板：

```yaml
apiVersion: monitoring.kubesphere.io/v1alpha2
kind: Dashboard
metadata:
  name: hardware-monitoring
spec:
  title: "硬件设备监控"
  panels:
    - title: "服务器温度 Top 5"
      metrics:
        - ipmi_temperature_celsius
      type: ranking
    - title: "交换机端口流量"
      metrics:
        - ifHCInOctets
      type: graph
```

---

## 三、实施步骤（3 步）

### Step 1：部署 Exporter

```bash
# 每台物理服务器上部署 node_exporter
wget https://github.com/prometheus/node_exporter/releases/latest/download/node_exporter-linux-amd64.tar.gz
tar xzf node_exporter-*.tar.gz
./node_exporter --web.listen-address=:9100 &

# ipmi_exporter 集中部署一台，远程采集所有服务器 IPMI
./ipmi_exporter --config.file=ipmi.yml &

# snmp_exporter 集中部署
./snmp_exporter --config.file=snmp.yml &
```

### Step 2：配置 KubeSphere 内置 Prometheus

```yaml
# kubectl edit secret prometheus-k8s-additional-scrape-config -n kubesphere-monitoring-system

- job_name: 'hardware-node'
  static_configs:
    - targets:
      - '10.0.0.1:9100'
      - '10.0.0.2:9100'

- job_name: 'hardware-ipmi'
  static_configs:
    - targets:
      - '10.0.0.1'
      - '10.0.0.2'
  relabel_configs:
    - target_label: __address__
      replacement: '10.0.0.100:9290'

- job_name: 'hardware-switch'
  params:
    module: ['if_mib']
  static_configs:
    - targets:
      - '10.0.254.1'
  relabel_configs:
    - target_label: __address__
      replacement: '10.0.0.100:9116'
```

### Step 3：创建自定义监控面板

在 KubeSphere 控制台「平台管理 → 自定义监控」中用 PromQL 创建硬件监控面板。

---

## 四、三层分工

| 层 | 工具 | 监控对象 |
|----|------|---------|
| 硬件层 | Prometheus + IPMI/SNMP/node_exporter | 服务器温度/风扇/电源、交换机端口、存储 |
| OS/容器层 | KubeSphere 内置 Prometheus | CPU、内存、磁盘、网络、Pod、K8s |
| 应用层 | 基调听云 APM | 代码性能、调用链、慢SQL、用户体验 |

---

## 五、客户价值总结

| 对比维度 | 传统方案（多工具拼凑） | KubeSphere + 硬件监控 |
|----------|---------------------|---------------------|
| 硬件监控 | Zabbix/SolarWinds（单独一套） | 接在 KubeSphere 内，统一入口 |
| 容器监控 | Prometheus + Grafana | KubeSphere 内置 |
| 应用监控 | 听云 APM（再一套） | 听云可对接 KubeSphere |
| 告警 | 各管各的，互相不知道 | AlertManager 统一路由，跨层关联 |
| 运维体验 | 切 4 个系统查问题 | 一个平台看三层 |
| License | 商业硬件监控要额外买 | KubeSphere + Exporter 全开源 |

**核心价值：把「硬件坏了 → 影响哪些容器 → 哪些业务受影响」这条链路在一个平台上串起来，MTTR 从 30 分钟降到 3 分钟。**
