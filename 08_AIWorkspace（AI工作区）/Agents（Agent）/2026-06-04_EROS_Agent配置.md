---
title: EROS Agent配置
date: 2026-06-04
type: AI工作区/Agent配置
tags:
  - agent
  - EROS
  - 售前
  - 多智能体
  - AI工作区
status: 正式版
version: "1.0"
author: EROS团队
---

# EROS Agent配置

> EROS（Enterprise Revenue Operating System）企业营收操作系统中的7大AI Agent定义。每个Agent负责售前流程中的特定环节，可独立运行也可编排协作。

---

## Agent架构总览

```
┌─────────────────────────────────────────────────────────────────┐
│                      EROS Agent 体系                             │
├───────────────┬───────────────┬───────────────┬─────────────────┤
│  AccountResearch │ CustomerIntel  │   Discovery    │ SolutionArchitect│
│  (客户研究)      │ (情报采集)      │ (需求探询)     │ (方案架构)        │
├───────────────┼───────────────┼───────────────┼─────────────────┤
│  DealStrategy    │ KSEArchitect   │ AIPlatformArchitect           │
│  (赢单策略)      │ (KSE方案)       │ (AI平台架构)                    │
└───────────────┴───────────────┴─────────────────────────────────┘
```

---

## 1. AccountResearch（客户研究Agent）

### 基本信息
| 属性 | 描述 |
|------|------|
| Agent ID | `account-research-001` |
| 定位 | 客户宏观研究 |
| 前置依赖 | 客户名称、行业信息 |
| 模型偏好 | 深度推理模型 |

### 核心任务
对目标客户进行360度全景研究，输出结构化的客户档案。

### 输入
```json
{
  "customer_name": "string",
  "industry": "string",
  "research_depth": "basic | standard | deep",
  "focus_areas": ["financial", "technical", "organizational", "market"],
  "data_sources": ["web_search", "internal_crm", "industry_reports"]
}
```

### 输出
```json
{
  "company_overview": {
    "founded": "string",
    "headquarters": "string",
    "revenue": "string",
    "employees": "string",
    "key_business": "string[]"
  },
  "financial_analysis": { ... },
  "technology_stack": { ... },
  "org_structure": { ... },
  "recent_news": [ ... ],
  "pain_point_hypothesis": [ ... ],
  "recommended_approach": "string"
}
```

### 触发条件
- 新建客户档案时自动触发
- 手动调用：`@AccountResearch 分析 {{客户名称}}`
- 定期刷新：客户信息超过90天未更新时触发

### 关联Prompt
- [[2026-06-04_售前场景Prompt库#1-客户画像生成Prompt|客户画像生成Prompt]]

---

## 2. CustomerIntelligence（客户情报Agent）

### 基本信息
| 属性 | 描述 |
|------|------|
| Agent ID | `customer-intel-001` |
| 定位 | 动态情报采集与分析 |
| 前置依赖 | AccountResearch输出 |
| 模型偏好 | 信息聚合模型 |

### 核心任务
持续采集客户动态信息，识别销售信号和风险信号。

### 输入
```json
{
  "customer_name": "string",
  "monitoring_topics": ["news", "job_postings", "funding", "leadership_changes", "technology_adoption"],
  "time_range": "7d | 30d | 90d",
  "signal_sensitivity": "high | medium | low"
}
```

### 输出
```json
{
  "signals": {
    "buying_signals": [ ... ],
    "risk_signals": [ ... ],
    "neutral_events": [ ... ]
  },
  "sentiment_analysis": { ... },
  "competitive_activity": [ ... ],
  "recommended_actions": [ ... ]
}
```

### 触发条件
- 每周一定时运行（监控模式）
- 客户进入销售漏斗时触发深度采集
- 手动调用：`@CustomerIntelligence 扫描 {{客户名称}}`

### 关联工作流
- [[2026-06-04_售前全流程工作流#阶段二情报采集与分析|情报采集阶段]]

---

## 3. Discovery（需求探询Agent）

### 基本信息
| 属性 | 描述 |
|------|------|
| Agent ID | `discovery-001` |
| 定位 | 需求挖掘与探询 |
| 前置依赖 | CustomerIntelligence输出 |
| 模型偏好 | 对话推理模型 |

### 核心任务
基于客户情报，生成针对性的需求探询框架和问题清单。

### 输入
```json
{
  "customer_profile": "{AccountResearch.output}",
  "intelligence_report": "{CustomerIntelligence.output}",
  "meeting_context": {
    "attendee_roles": ["CIO", "CTO", ...],
    "meeting_type": "initial | discovery | demo | negotiation",
    "previous_interactions": [ ... ]
  },
  "solution_portfolio": ["product_a", "product_b", ...]
}
```

### 输出
```json
{
  "discovery_framework": "SPIN | MEDDIC | Challenger",
  "key_questions": [
    {
      "question": "string",
      "purpose": "string",
      "expected_answer_signals": "string",
      "follow_up_if": "string"
    }
  ],
  "value_hypothesis": "string",
  "objection_anticipation": [ ... ],
  "meeting_agenda": "string",
  "talk_track": "string"
}
```

### 触发条件
- 客户拜访前48小时触发
- 销售请求需求分析时触发
- 手动调用：`@Discovery 准备 {{客户名称}} 的拜访`

### 关联Prompt
- [[2026-06-04_售前场景Prompt库#5-拜访话术生成Prompt|拜访话术生成Prompt]]

---

## 4. SolutionArchitect（方案架构Agent）

### 基本信息
| 属性 | 描述 |
|------|------|
| Agent ID | `solution-architect-001` |
| 定位 | 技术方案设计与输出 |
| 前置依赖 | Discovery输出、产品知识库 |
| 模型偏好 | 技术推理模型 |

### 核心任务
根据需求探询结果，设计定制化技术方案。

### 输入
```json
{
  "customer_requirements": "{Discovery.output}",
  "product_catalog": ["...参考02_Products知识库"],
  "technical_constraints": {
    "existing_systems": ["..."],
    "compliance": [ "..." ],
    "performance": { ... }
  },
  "budget_range": "string",
  "timeline": "string",
  "solution_type": "full | mvp | poc"
}
```

### 输出
```json
{
  "architecture_overview": "string",
  "solution_diagram": "string (mermaid/text)",
  "module_design": [ ... ],
  "integration_plan": { ... },
  "bom": { ... },
  "implementation_roadmap": [ ... ],
  "competitive_advantages": [ ... ],
  "risks_and_mitigations": [ ... ]
}
```

### 触发条件
- 需求确认后触发方案设计
- 招标文件收到后触发标书方案
- 手动调用：`@SolutionArchitect 为 {{客户名称}} 设计方案`

### 关联Prompt
- [[2026-06-04_售前场景Prompt库#3-技术方案生成Prompt|技术方案生成Prompt]]
- [[2026-06-04_售前场景Prompt库#4-标书应答Prompt|标书应答Prompt]]

---

## 5. DealStrategy（赢单策略Agent）

### 基本信息
| 属性 | 描述 |
|------|------|
| Agent ID | `deal-strategy-001` |
| 定位 | 赢单策略与竞争博弈 |
| 前置依赖 | SolutionArchitect输出、竞品信息 |
| 模型偏好 | 策略推理模型 |

### 核心任务
分析竞争态势，制定赢单策略和行动计划。

### 输入
```json
{
  "deal_context": {
    "customer_name": "string",
    "deal_size": "string",
    "deal_stage": "string",
    "competitors": [ ... ],
    "decision_criteria": [ ... ]
  },
  "our_solution": "{SolutionArchitect.output}",
  "competitive_intel": [ ... ],
  "relationship_map": { ... }
}
```

### 输出
```json
{
  "win_probability": "percentage",
  "strategy_summary": "string",
  "battle_card": {
    "strengths_to_emphasize": [ ... ],
    "weaknesses_to_defend": [ ... ],
    "competitor_weaknesses_to_exploit": [ ... ],
    "key_messages": [ ... ]
  },
  "action_plan": [ ... ],
  "pricing_strategy": { ... },
  "relationship_actions": [ ... ],
  "critical_success_factors": [ ... ]
}
```

### 触发条件
- 进入正式竞争阶段时触发
- 竞品动态变化时触发策略调整
- 手动调用：`@DealStrategy 分析 {{客户名称}} 的赢单策略`

### 关联Prompt
- [[2026-06-04_售前场景Prompt库#2-竞品分析Prompt|竞品分析Prompt]]

---

## 6. KSEArchitect（KSE方案架构Agent）

### 基本信息
| 属性 | 描述 |
|------|------|
| Agent ID | `kse-architect-001` |
| 定位 | KSE（Key Solution Element）核心方案元素架构 |
| 前置依赖 | SolutionArchitect输出 |
| 模型偏好 | 领域专家模型 |

### 核心任务
针对特定行业/场景的KSE模块进行深度方案设计。

### 输入
```json
{
  "kse_type": "data_platform | ai_platform | cloud_native | security | observability",
  "customer_context": "{SolutionArchitect.output}",
  "industry_requirements": [ ... ],
  "reference_architectures": [ ... ]
}
```

### 输出
```json
{
  "kse_architecture": { ... },
  "component_specs": [ ... ],
  "deployment_topology": { ... },
  "performance_benchmarks": { ... },
  "best_practices": [ ... ],
  "industry_compliance": [ ... ]
}
```

### 触发条件
- 技术方案需要行业化定制时触发
- POC/原型验证阶段触发
- 手动调用：`@KSEArchitect 设计 {{KSE类型}} 方案`

### 相关知识库
- [[05_Solutions（解决方案库）]]
- [[06_Architecture（架构设计库）]]

---

## 7. AIPlatformArchitect（AI平台架构Agent）

### 基本信息
| 属性 | 描述 |
|------|------|
| Agent ID | `ai-platform-architect-001` |
| 定位 | AI基础设施与平台架构 |
| 前置依赖 | KSEArchitect输出、技术栈信息 |
| 模型偏好 | AI专业模型 |

### 核心任务
设计面向客户的AI平台/MLOps/LLMOps架构方案。

### 输入
```json
{
  "ai_requirements": {
    "use_cases": [ "..." ],
    "model_types": [ "..." ],
    "data_requirements": { ... },
    "inference_requirements": { ... }
  },
  "infrastructure_context": "{KSEArchitect.output}",
  "compliance_requirements": [ ... ],
  "cost_constraints": { ... }
}
```

### 输出
```json
{
  "ai_platform_architecture": { ... },
  "model_serving_topology": { ... },
  "data_pipeline_design": { ... },
  "mlops_workflow": { ... },
  "gpu_cluster_design": { ... },
  "cost_estimation": { ... },
  "governance_framework": { ... }
}
```

### 触发条件
- 客户需求涉及AI/ML平台时触发
- 大模型落地场景评估时触发
- 手动调用：`@AIPlatformArchitect 设计AI平台方案`

---

## Agent编排规则

### 串行调用链
```
AccountResearch → CustomerIntelligence → Discovery → SolutionArchitect → DealStrategy
                                                              ↓
                                                         KSEArchitect
                                                              ↓
                                                      AIPlatformArchitect
```

### 并行调用
- `AccountResearch` 和 `CustomerIntelligence` 可并行（无依赖时）
- `DealStrategy` 可与 `KSEArchitect` 并行

### 触发策略
| 策略 | 说明 |
|------|------|
| 自动触发 | 满足触发条件时由工作流引擎自动调度 |
| 手动调用 | 使用 `@AgentName` 语法手动激活 |
| 定时触发 | 按周期自动执行（如每周情报刷新） |

### 状态管理
每个Agent运行后会更新共享上下文，后续Agent可读取前置Agent的输出。状态存储在Obsidian的Agent状态文件中。

---

## 使用说明

### 快速开始
1. 在Obsidian中输入 `@AccountResearch 分析 XX公司`
2. 等待Agent完成研究后，自动触发下游Agent
3. 或手动编排：`@Discovery 准备 XX公司 拜访`

### 配置调优
- 每个Agent的模型偏好可根据实际效果调整
- 输出格式可在Agent配置中自定义
- 触发条件可通过工作流引擎修改

### 相关资源
- [[2026-06-04_售前场景Prompt库]] — Prompt模板库
- [[2026-06-04_售前全流程工作流]] — 工作流定义
- [[2026-06-04_MCP工具配置指南]] — 工具配置
