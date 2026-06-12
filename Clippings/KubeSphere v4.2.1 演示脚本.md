---
title: "KubeSphere v4.2.1 演示脚本"
source: "http://localhost:8888/20260611_081529_KSE%E6%BC%94%E7%A4%BA%E8%84%9A%E6%9C%AC.html"
author:
published:
created: 2026-06-11
description:
tags:
  - "clippings"
---
演示KubeSphere售前脚本

## 演示环境

| 项目 | 内容 |
| --- | --- |
| 版本 | KubeSphere v4.2.1 |
| URL | 139.198.121.90:30185 |
| 集群 | host（9节点）+ member-1（开发环境） |
| 企业空间 | 47个 \| 用户48个 \| 扩展44个 |
| 演示应用 | abctest/nginx124+nginx02双版本 \| Bookinfo微服务 |

## 演示流程（30-35分钟）

| 阶段 | 时长 | 内容 |
| --- | --- | --- |
| ① 平台全局 | 3min | 首页 — 微内核可插拔 |
| ② 多集群 | 3min | host+member-1，9节点全绿 |
| ③ 多租户 ★ | 5min | 企业空间→配额→权限 |
| ④ 工作负载 ★ | 5min | 滚动更新+回滚+终端 |
| ⑤ 微服务路由 | 4min | Bookinfo+Ingress |
| ⑥ 可观测性 | 4min | 六层下钻+日志+告警 |
| ⑦ 总结 | 3min+ | 六能力三优势 |

## 操作路径

```
首页→集群管理→host→节点
首页→企业空间→poc→项目→配额
工作负载→abctest→nginx124→编辑镜像
Pod→终端→日志
```

## 常见问答

| 问题 | 应答 |
| --- | --- |
| 和Rancher比？ | 多租户+全开源，Rancher许可证收紧 |
| 和OpenShift比？ | 轻量+不绑OS+成本优势 |
| 稳定吗？ | 山东港口三年，年均工单6个 |
| 扩容？ | 加节点→一条命令→不中断 |

## 演示禁忌

- 不现场改配置 | 不解释技术名词
- 不主动提竞品 | 不超35分钟
<iframe src="chrome-extension://cnjifjpddelmedmihgijeibhnjfabmlf/side-panel.html?context=iframe"></iframe>