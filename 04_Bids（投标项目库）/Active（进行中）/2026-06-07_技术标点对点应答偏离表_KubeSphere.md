---
tags: [投标, 点对点应答, 偏离表, KubeSphere, 容器平台, 技术标]
created: 2026-06-07
source: ~/Desktop/KubeSphere_技术标点对点应答偏离表.xlsx
source_image: ~/Library/Containers/com.tencent.xinWeChat/Data/Documents/xwechat_files/wxid_c30n5ofy19a022_5ffb/msg/file/2026-05/技术标评分表v1.0.xlsx
parent: "[[04_Bids（投标项目库）/README]]"
---

# 技术标评分表 — 点对点应答偏离表（KubeSphere 容器平台）

> 生成日期：2026-06-07 | 工具：Hermes Agent + Univer | 产品版本：KubeSphere v4.2.1

## 概述

基于招标文件《技术标评分表v1.0》（标段一），以青云KubeSphere容器平台为核心产品，逐条对照生成点对点应答偏离表。

## 评分结构

| 评分大类 | 分值 | 响应情况 |
|---------|------|---------|
| 企业综合实力 | 15分 | ✅ 全部满足 |
| 平台要求 | 40分 | ⚠️ 2项需关注（CNCF会员、底层OS） |
| 技术方案 | 35分 | ✅ 全部满足 |
| 项目管理 | 10分 | ✅ 全部满足 |
| 诚信分 | 0分 | ✅ 无扣分 |
| 加分项 | 8~15分 | ✅ 可提供多项增值服务 |

## 关键发现

### 🔴 确定性失分项

| 序号 | 评分项 | 分值 | 原因 |
|------|-------|------|------|
| 2.1 | CNCF白金会员 | 2分 | 青云非CNCF白金会员（KubeSphere为CNCF Certified K8s发行版） |

### 🟡 需方案补充项

| 序号 | 评分项 | 分值 | 补充策略 |
|------|-------|------|---------|
| 2.2 | 底层系统 | 6分 | KubeSphere不绑定OS，可配合客户现有OS体系或配套云易捷超融合提供原厂OS支持 |

### 🟢 核心竞争优势项

- **源代码提供**（2.6）：100%开源Apache 2.0，全版本源代码交付 — 竞品中独一无二
- **K8s原生兼容性**（2.9）：无私有API锁定，kubectl全兼容 — vs OpenShift私有API、ACK云锁定
- **可插拔扩展架构**（2.4/2.8）：LuBan微内核+热插拔，按需启用功能 — 降低平台复杂度
- **多集群异构纳管**（2.4）：纳管OpenShift/RKE/ACK/GKE等异构集群 — 保护客户已有投资

## 预估得分

| 项目 | 分值 |
|------|------|
| 技术分理论满分 | 100分 |
| 确定性失分（CNCF） | -2分 |
| OS项（保守估计） | -2~4分 |
| 基础预估 | 94~96分 |
| 加分项预估 | +8~15分 |
| 最终预估 | **92~100分**（上限100） |

## 后续行动

1. 确认CNCF会员升级可行性和成本（Gold会员年费评估）
2. 准备OS支持方案（客户现有OS兼容性矩阵 / 云易捷超融合方案）
3. 整理证书原件：CKA/CKS/CKAD证书、ISO9001/27001等体系认证
4. 准备类似项目合同复印件（脱敏）

## 关联文件

- 📊 偏离表Excel：[KubeSphere_技术标点对点应答偏离表.xlsx](file:///Users/zhu/Desktop/KubeSphere_技术标点对点应答偏离表.xlsx)
- 📋 原始招标文件：[技术标评分表v1.0.xlsx](file:///Users/zhu/Library/Containers/com.tencent.xinWeChat/Data/Documents/xwechat_files/wxid_c30n5ofy19a022_5ffb/msg/file/2026-05/技术标评分表v1.0.xlsx)
- 📄 产品白皮书：[KubeSphere 容器平台白皮书 v4](file:///Users/zhu/SalesVault/产品知识库/容器平台/KubeSphere%20容器平台白皮书%20v4%20(2).pdf)
- 📋 资质汇总：[[2026-06-07_青云资质证书汇总]]
- 📄 产品概览：[[2026-06-04_KubeSphere概览]]
