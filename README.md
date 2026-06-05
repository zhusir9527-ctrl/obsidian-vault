---
tags: [EROS, KnowledgeBase, Index]
created: 2026-06-04
---

# 🏛️ EROS Knowledge Base

> **Enterprise Revenue OS（EROS）— 企业项目AI销售作战平台知识库**
> 初始化于 2026-06-04 11:01

---

## 目录结构总览

| 编号 | 目录 | 用途 |
|------|------|------|
| 00 | [[00_Inbox（收件箱）/README|收件箱]] | 信息入口，自动分拣 |
| 01 | [[01_Foundation（基础知识库）/README|基础知识库]] | 技术原理 · 行业知识 |
| 02 | [[02_Products（产品知识库）/README|产品知识库]] | 产品资料 · 竞品分析 |
| 03 | [[03_Customers（客户知识库）/README|客户知识库]] | 客户画像 · 决策链 · 商机 |
| 04 | [[04_Bids（投标项目库）/README|投标项目库]] | 投标管理 · 赢单复盘 |
| 05 | [[05_Solutions（解决方案库）/README|解决方案库]] | 标准方案沉淀 |
| 06 | [[06_Architecture（架构设计库）/README|架构设计库]] | 架构设计 · 网络规划 |
| 07 | [[07_SalesPlaybook（销售作战库）/README|销售作战库]] | 销售方法论 |
| 08 | [[08_AIWorkspace（AI工作区）/README|AI工作区]] | AI指挥中心 |
| 09 | [[09_DailyNotes（日记与复盘）/README|日记与复盘]] | 日报 · 复盘 |
| 10 | [[10_Resources（资源中心）/README|资源中心]] | 资料归档 |
| 11 | [[11_BusinessOS（企业销售作战系统）/README|企业作战系统]] | EROS核心 · 7-Agent |

---

## 数据流

```
微信/邮件/会议/标书
        ↓
 00_Inbox（收件箱）
   Agent 自动分拣 ↓
        ↓
  01~11 各知识库
   Agent 持续更新 ↓
        ↓
  11_BusinessOS（作战层）
   → 客户研究 → 情报 → 方案 → 投标 → 成交
```

---

## 标签体系

### 技术领域
`#Cloud` `#Virtualization` `#Container` `#Kubernetes` `#Storage` `#Network` `#Security` `#Database` `#Middleware` `#AI` `#HPC`

### 业务对象
`#Customer` `#Project` `#Bid` `#POC` `#Opportunity`

### 厂商品牌
`#QingCloud` `#Huawei` `#AlibabaCloud` `#AWS` `#TencentCloud` `#ZDNS` `#Sangfor` `#H3C`

### 行业
`#Manufacturing` `#Finance` `#Government` `#Education` `#Healthcare` `#Energy` `#Transportation` `#Internet`

### 项目状态
`#Active` `#Won` `#Lost`

### 工作类型
`#Sales` `#Architecture` `#Solution` `#Strategy` `#Playbook`

### 系统
`#EROS` `#RevenueOS` `#Inbox`

---

## 统一文件命名规范

**格式：** `YYYY-MM-DD_主题名称.md`

**示例：**
- `2026-06-04_Kubernetes网络架构分析.md`
- `2026-06-04_零跑汽车DNS需求分析.md`
- `2026-06-04_青云云原生方案v2.md`
- `2026-06-04_振石股份K8s升级投标复盘.md`

---

## Agent 工作原则

1. **入口唯一** — 所有新内容先进 00_Inbox
2. **自动分拣** — Agent 识别内容类型，分发到对应目录
3. **结构优先** — 先建目录再放文件，避免根目录散落
4. **关联自动** — 客户↔项目↔方案↔竞品 自动建立 Wikilink
5. **索引同步** — 新增内容后自动更新所属目录 README
6. **RAG友好** — 所有文件含 frontmatter、标签、摘要
7. **一切服务于销售成交**

---

*EROS Knowledge Base v3 · 构建于 2026-06-04 11:01*
