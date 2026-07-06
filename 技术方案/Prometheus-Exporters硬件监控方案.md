---
topic: 硬件监控
tool: Prometheus + Exporters
type: 技术方案
date: 2026-07-06
---

# Prometheus + Exporters 硬件监控方案

## 一、核心原理

Prometheus 不主动采集数据，通过 HTTP 协议定期去各个 Exporter 的 `/metrics` 端点**拉取**数据。Exporter 是翻译层，把 SNMP、IPMI、Redfish、SMART 等硬件协议统一翻译成 Prometheus metrics 格式。

```
硬件设备 → Exporter（翻译官） → Prometheus Server（定期拉取） → Grafana（可视化）
```

---

## 二、Exporter 选型矩阵

### 服务器主机监控
| Exporter | 采集内容 | 部署方式 |
|----------|---------|---------|
| node_exporter | CPU、内存、磁盘IO、网络流量、文件系统 | 每台服务器一个 Agent |
| windows_exporter | Windows 服务器同等指标 | Windows 服务 |

### 服务器硬件健康（带外监控）
| Exporter | 采集内容 | 适用品牌 |
|----------|---------|---------|
| ipmi_exporter | 温度、风扇转速、电源状态、电压 | 通用（任何支持 IPMI 的服务器） |
| redfish_exporter | 同上，走 Redfish 协议 | 新一代服务器（iDRAC9+、iLO5+） |
| dell_exporter | PERC RAID、iDRAC 详情 | Dell PowerEdge |
| hp_exporter | iLO 详情 | HPE ProLiant |
| lenovo_exporter | XClarity 集成 | 联想 ThinkSystem |

### 网络设备
| Exporter | 采集内容 | 适用 |
|----------|---------|------|
| snmp_exporter | 端口流量、错误包、CPU、内存、温度 | 任意交换机/路由器/防火墙 |

### 存储设备
| 方案 | 采集内容 |
|------|---------|
| snmp_exporter | 存储阵列通用 SNMP MIB |
| NetApp harvest | NetApp 存储专用 |

### 其他专用
| Exporter | 用途 |
|----------|------|
| smartctl_exporter | 硬盘 SMART（坏道、寿命） |
| nvidia_gpu_exporter | GPU 温度、利用率、显存 |
| blackbox_exporter | ICMP/TCP/HTTP 拨测 |

---

## 三、生产环境部署架构

```
机器规划（3台起步）：

1. Prometheus Server（4C8G，200G SSD）
   - prometheus 主进程（采集+存储）
   - 默认保留 15 天数据

2. Grafana（2C4G）
   - 仪表板可视化
   - 告警面板

3. AlertManager（可选，可和 Prometheus 同机）
   - 告警路由到微信/钉钉/邮件
```

### prometheus.yml 核心配置

```yaml
global:
  scrape_interval: 15s

scrape_configs:
  # 每台服务器的基础指标
  - job_name: 'node'
    static_configs:
      - targets:
        - '10.0.0.1:9100'
        - '10.0.0.2:9100'
        - '10.0.0.3:9100'

  # 服务器硬件健康（IPMI）
  - job_name: 'ipmi'
    params:
      module: ['default']
    static_configs:
      - targets:
        - '10.0.0.1'
        - '10.0.0.2'
    relabel_configs:
      - target_label: __address__
        replacement: '10.0.0.100:9290'

  # 交换机监控（SNMP）
  - job_name: 'switch'
    params:
      module: ['if_mib']
    static_configs:
      - targets:
        - '10.0.254.1'
        - '10.0.254.2'
    relabel_configs:
      - target_label: __address__
        replacement: '10.0.0.100:9116'
```

---

## 四、告警规则

```yaml
groups:
  - name: hardware
    rules:
      - alert: ServerTemperatureHigh
        expr: ipmi_temperature_celsius > 75
        for: 5m
        labels:
          severity: warning
        annotations:
          summary: "{{ $labels.instance }} 温度 {{ $value }}°C"

      - alert: DiskSpaceCritical
        expr: (node_filesystem_avail_bytes / node_filesystem_size_bytes) < 0.1
        for: 1m
        labels:
          severity: critical

      - alert: PhysicalDiskFailed
        expr: ipmi_disk_status != 1
        labels:
          severity: critical

      - alert: SwitchPortDown
        expr: ifOperStatus == 2
        for: 2m
        labels:
          severity: critical
```

---

## 五、与基调听云的分工

| 层 | 工具 | 监控对象 |
|----|------|---------|
| 硬件层 | Prometheus + IPMI/SNMP Exporters | 服务器温度/风扇/电源、交换机端口、存储、UPS |
| OS/容器层 | Prometheus + node_exporter | CPU、内存、磁盘、网络、K8s |
| 应用层 | 基调听云 APM | 代码性能、调用链、慢SQL、用户体验 |

---

## 六、优缺点

**优势：**
- 开源免费，无 License 成本
- Exporter 生态极丰富（官方 200+、社区不计其数）
- Grafana 仪表板社区模板海量（直接导入 Dashboard ID）
- 告警规则灵活，可对接任意 Webhook
- 与 K8s 原生集成，容器环境首选

**劣势：**
- 需要运维能力（部署、调优、写 PromQL）
- 长期存储需要额外组件（Thanos/Cortex/VictoriaMetrics）
- 没有开箱即用的 CMDB/拓扑发现
- 告警管理不如商业产品完善
