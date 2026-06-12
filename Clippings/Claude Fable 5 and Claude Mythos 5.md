---
title: "Claude Fable 5 and Claude Mythos 5"
source: "https://www.anthropic.com/news/claude-fable-5-mythos-5"
author:
published:
created: 2026-06-12
description: "Today we’re launching Claude Fable 5: a Mythos-class model that we’ve made safe for general use."
tags:
  - "clippings"
---
## Claude Fable 5 and Claude Mythos 5Claude Fable 5 和 Claude Mythos 5

2026年6月9日

Today we’re launching **Claude Fable 5**: a Mythos-class <sup>1</sup> model that we’ve made safe for general use.  
今天我们发布了 Claude Fable 5：一款我们已使其适用于通用场景的 Mythos 级 <sup>1</sup> 模型。

Fable 5’s capabilities exceed those of any model we’ve ever made generally available. It is state-of-the-art on nearly all tested benchmarks of AI capability, showing exceptional performance in software engineering, knowledge work, vision, scientific research, and many other areas. The longer and more complex the task, the larger Fable 5’s lead over our other models.  
Fable 5 的功能超越了我们所制作的任何一款公开发布的模型。它在几乎所有测试的 AI 能力基准中都处于顶尖水平，在软件工程、知识工作、视觉、科学研究以及其他许多领域都展现出卓越的性能。任务越长期、越复杂，Fable 5 相对于我们其他模型的领先优势就越大。

Releasing a model this capable comes with risks. Without safeguards, Fable 5’s capabilities in areas like cybersecurity could be misused to cause serious damage. We’ve therefore launched the model with safeguards that mean queries on some topics will instead receive a response from our next-most-capable model, Claude Opus 4.8. To release the model both safely and quickly, we’ve tuned these safeguards conservatively—they’ll sometimes catch harmless requests, though they trigger, on average, in less than 5% of sessions. With more capable models arriving in the coming months, we’re working to improve our safeguards and reduce false positives as quickly as we can.  
发布这样一个强大的模型伴随着风险。如果没有安全防护措施，Fable 5 在网络安全等领域的功能可能会被误用造成严重损害。因此，我们推出了带有安全防护措施的模型，这意味着关于某些主题的查询将改由我们下一款最强大的模型 Claude Opus 4.8 进行响应。为了安全且快速地发布模型，我们对这些安全防护措施进行了保守的调整——它们有时会拦截无害的请求，尽管会触发，但平均仅在不到 5%的会话中触发。随着未来几个月将推出更强大的模型，我们正努力改进我们的安全防护措施，并尽快减少误报。

For a small group of cyberdefenders and infrastructure providers, we’re also launching **Claude Mythos 5**. It’s the same underlying model as Fable 5, but with the safeguards lifted in some areas.<sup>2</sup> Mythos 5 will initially be deployed through [Project Glasswing](https://www.anthropic.com/glasswing), in collaboration with the US government, as an upgrade to Claude Mythos Preview. It has the strongest cybersecurity capabilities of any model in the world. Soon, we intend to expand access to Mythos 5 through a broader trusted access program.  
对于一小部分网络防御者和基础设施提供者，我们还将推出 Claude Mythos 5。它使用与 Fable 5 相同的底层模型，但在某些领域移除了安全防护措施。 <sup>2</sup> Mythos 5 最初将通过与美国政府合作的 Project Glasswing 项目部署，作为 Claude Mythos Preview 的升级版本。它是世界上任何模型中网络安全能力最强的。不久，我们打算通过更广泛的受信任访问计划扩大 Mythos 5 的访问权限。

The capabilities of models like Fable 5 and Mythos 5 have the potential to do profound good for the world. We’ve seen the beginnings of this in Project Glasswing, where the models have [helped cyber defenders](https://www.anthropic.com/research/glasswing-initial-update) secure critically important software. We’ve also seen it in life sciences research, where the models are positing novel hypotheses and speeding up the development of new therapeutics.  
像 Fable 5 和 Mythos 5 这样的模型的能力有潜力为世界带来深远的好处。我们在 Project Glasswing 中看到了这一点，这些模型帮助网络防御者保障了关键软件的安全。我们在生命科学研究中也看到了这一点，这些模型正在提出新的假设，并加速新疗法的开发。

Fable 5 and Mythos 5 are being offered at $10 per million input tokens and $50 per million output tokens—less than half the price of Claude Mythos Preview. Today’s joint launch is another step towards our goal of bringing advanced AI capabilities to as many users as possible, as quickly and as safely as we can.  
Fable 5 和 Mythos 5 的价格分别为每百万输入 token 10 美元和每百万输出 token 50 美元——不到 Claude Mythos Preview 价格的一半。今天的联合发布是我们将先进 AI 能力尽可能快速、安全地带给尽可能多用户目标的一部分。

## Evaluating Claude Fable 5 and Claude Mythos 5评估 Claude Fable 5 和 Claude Mythos 5

The table below compares the capabilities of Fable 5 and Mythos 5 to other leading models.  
下表比较了 Fable 5 和 Mythos 5 与其他领先模型的能力。

![Benchmark table showing Claude Fable and Mythos compared to other leading models](https://www.anthropic.com/_next/image?url=https%3A%2F%2Fwww-cdn.anthropic.com%2Fimages%2F4zrzovbb%2Fwebsite%2F1e65982497d7d4891219ed0e83141625a291b860-2600x2870.png&w=3840&q=75)

Benchmark table showing Claude Fable and Mythos compared to other leading models

Fable 5 and Mythos 5 can work autonomously for longer than any previous Claude models. Below we discuss how these skills apply to software engineering, and cover the model’s improved capabilities in knowledge work, vision, memory, and life sciences research.  
Fable 5 和 Mythos 5 可以比任何之前的 Claude 模型更长时间地自主工作。下面我们讨论这些技能如何应用于软件工程，并涵盖模型在知识工作、视觉、记忆和生命科学研究方面的改进能力。

*Software engineering.* During early testing, [Stripe](https://stripe.com/) reported that Fable 5 compressed months of engineering into days. In a 50-million-line Ruby codebase, the model performed a codebase-wide migration in a day that would otherwise have taken a whole team over two months by hand. Fable 5 is also more token-efficient than past Claude models: on Cognition’s [FrontierCode](https://cognition.ai/blog/frontier-code) evaluation, which tests whether models can pass difficult coding tasks while meeting the standards of high-quality production codebases, Fable 5 scores highest among frontier models, even at medium effort.  
软件工程。在早期测试中，Stripe 报告称 Fable 5 将数月的工程工作压缩到几天内。在一个包含 500 万行 Ruby 代码的代码库中，该模型在一天内完成了通常需要整个团队手动花费两个月才能完成的代码库迁移。Fable 5 比过去的 Claude 模型更具有 token 效率：在 Cognition 的 FrontierCode 评估中，该评估测试模型是否能够在符合高质量生产代码库标准的同时通过困难的编码任务，Fable 5 在前沿模型中得分最高，即使在中等努力程度下也是如此。

![](https://www.anthropic.com/_next/image?url=https%3A%2F%2Fwww-cdn.anthropic.com%2Fimages%2F4zrzovbb%2Fwebsite%2Fd3c3efe0e8ab310856368cee2b2161439db6676a-1920x1080.png&w=3840&q=75)

![](https://www.anthropic.com/_next/image?url=https%3A%2F%2Fwww-cdn.anthropic.com%2Fimages%2F4zrzovbb%2Fwebsite%2F036229d8f9be9a5a911dbbd863b3c6cc09a79a70-3840x2160.png&w=3840&q=75)

*Knowledge work*. Fable 5 shows strong performance on complex analytical tasks. On [Hebbia](https://www.hebbia.com/) ’s Finance Benchmark for senior-level reasoning, Fable 5 has the highest score of any model, with substantial gains in document-based reasoning, chart and table interpretation, and problem solving. [IMC](https://www.imc.com/) noted that Fable 5 aced their trading-analysis evaluations nearly across the board, including factual lookup, conceptual reasoning, root-cause analysis, and expected-value analysis.  
知识型工作。Fable 5 在复杂分析任务上表现出色。在 Hebbia 的金融基准测试中，针对高级推理能力，Fable 5 获得了所有模型中最高的分数，并在基于文档的推理、图表和表格解读以及问题解决方面取得了显著提升。IMC 指出，Fable 5 在其交易分析评估中几乎全面超越，包括事实查询、概念推理、根本原因分析和预期价值分析。

*Vision.* Fable 5 is the new state-of-the-art model for tasks involving vision. It can extract precise numbers from detailed scientific figures and can perform complex vision-based tasks like rebuilding a web app’s source code from screenshots alone. It also needs less scaffolding: for example, previous Claude models struggled to play Pokémon FireRed even with harnesses that gave them additional helpful tools, but Fable 5 beat FireRed with a minimal, vision-only harness.  
愿景。Fable 5 是用于涉及视觉任务的新一代顶尖模型。它可以从详细的科学图表中提取精确数字，并且能够执行复杂的基于视觉的任务，例如仅凭截图就重建网络应用的源代码。它还需要较少的辅助工具：例如，之前的 Claude 模型即使使用提供了额外有用工具的辅助工具，也难以玩 Pokémon FireRed，但 Fable 5 仅使用最小化的、仅基于视觉的辅助工具就击败了 FireRed。

![](https://www.youtube.com/watch?v=Ty_50J84fMY)

A timelapse of Claude playing Pokémon FireRed from start to finish using only raw game screenshots — with no maps, navigation aids, or extra game-state information. Earlier Claude models needed a complex helper harness to play Pokémon; Claude Fable 5 completed the game with vision alone.  
使用仅包含原始游戏截图的时间轴展示 Claude 从开始到结束玩《宝可梦 火红》的过程——不使用地图、导航辅助或额外的游戏状态信息。早期的 Claude 模型需要复杂的辅助工具才能玩《宝可梦》；Claude Fable 5 仅凭视觉就完成了游戏。

*Memory and long-context.* Fable 5 stays focused across millions of tokens in long-running tasks and improves its outputs using its own notes. When we had the model play the deck-building game [*Slay the Spire*](https://en.wikipedia.org/wiki/Slay_the_Spire), giving it access to persistent file-based memory improved its performance three times more than for Opus 4.8; Fable also reached the game’s final act three times more often.  
记忆和长上下文。Fable 5 在长时间运行的任务中保持专注，跨越数百万个 token，并利用自己的笔记改进输出。当我们将模型用于玩卡牌构筑游戏《斩杀巨龙》时，给予其访问持久化文件记忆的能力使其性能比 Opus 4.8 提高了三倍；Fable 还更频繁地达到游戏的最终章节。

![](https://www.youtube.com/watch?v=5f5JYLZHdhw)

Claude Fable 5 built this simulation of the solar system, deriving the planets' orbital motion from physics first principles and using it to predict solar eclipses.  
Claude Fable 5 建造了这个太阳系模拟，从物理学基本原理推导出行星的轨道运动，并用它来预测日食。

*Drug design:* Using Mythos 5, our internal protein design experts accelerated aspects of the drug design process by around ten times. In one example, they found that Mythos 5, with protein design and bioinformatics tools but no human assistance, matches or beats skilled human operators. In doing so, the model executes all of the tasks that are normally completed by a scientist: choosing binding sites, selecting and running protein design tools, and recovering from failures along the way. Nine of the 14 protein targets from this study (shown below) yielded strong candidates for drug design that we’re currently investigating.  
药物设计：利用 Mythos 5，我们内部的专业蛋白质设计专家将药物设计流程的某些方面加速了约十倍。在其中一个例子中，他们发现仅依靠蛋白质设计和生物信息学工具，无需人类协助的 Mythos 5，其性能可以与熟练的人类操作员相媲美甚至超越。在这个过程中，该模型执行了通常由科学家完成的全部任务：选择结合位点、选择并运行蛋白质设计工具，以及在过程中从失败中恢复。这项研究中 14 个蛋白质靶点中的 9 个（如下所示）产生了强效的药物设计候选物，我们目前正在对此进行研究。

![](https://www.anthropic.com/_next/image?url=https%3A%2F%2Fwww-cdn.anthropic.com%2Fimages%2F4zrzovbb%2Fwebsite%2F6a97019c4d8ea13fdd7200455f6dd9e8c267ba0b-1920x1080.png&w=3840&q=75)

Protein complexes designed by Mythos 5. Targets include immune checkpoints, growth-factor and receptor signaling, neurodegeneration, muscle disease, and harder structural targets. 由 Mythos 5 设计的蛋白质复合物。靶点包括免疫检查点、生长因子和受体信号传导、神经退行性疾病、肌肉疾病以及更难的结构性靶点。

*Novel hypotheses in molecular biology.* Mythos 5 is our first model to consistently produce novel, compelling scientific hypotheses. In blinded head-to-head comparisons against Opus-class models, our scientists preferred Mythos’s molecular biology hypotheses ~80% of the time, and have advanced several to experimental evaluation. In the meantime, one Mythos hypothesis—a novel mechanism for an *E. coli* protein—was corroborated in [a study](https://www.biorxiv.org/content/10.64898/2026.03.12.711259v1) from a lab independently working on the same problem.  
分子生物学的创新假设。Claude Mythos 5 是我们首个能够持续产出新颖且引人入胜的科学假设的模型。在盲法头对头对比 Opus 级模型时，我们的科学家在 80% 的情况下更倾向于 Mythos 提出的分子生物学假设，并且已将其中数个推进到实验验证阶段。与此同时，一个来自 Mythos 的假设——关于大肠杆菌蛋白的新机制——在一个独立研究同一问题的实验室研究中得到了证实。

*Novel research in genomics.*Mythos 5 conducted novel genomics research in over a week of largely autonomous work. It assembled single-cell data for millions of cells spanning 138 animal species and designed and trained a custom machine learning model to identify cells performing the same role in even distantly related organisms. With only high-level human input, Mythos 5’s trained model outperformed a recent model published in the journal *Science* —despite being 100 times smaller. We intend to publish these results in the coming months.  
基因组学领域的最新研究。Mythos 5 在一周多的主要自主工作中进行了创新的基因组学研究。它组装了跨越 138 种动物物种的数百万个单细胞数据，并设计并训练了一个定制的机器学习模型，用于识别即使在亲缘关系较远的生物中执行相同功能的细胞。仅凭高级别的人类输入，Mythos 5 训练的模型在规模仅为其 1/100 的情况下，性能优于近期发表在《科学》杂志上的模型。我们计划在未来几个月内发表这些结果。

*Alignment*. In our automated alignment assessment we found that Mythos 5’s level of misaligned behavior (including misaligned actions taken by the model such as deception, and cooperation with misuse of the model by a user) was low, and similar to that of Opus 4.8. Given they are the same underlying model, Fable 5’s level of alignment will be similar. The assessment is described in full, along with a detailed suite of other safety and capabilities tests, in the model’s [system card](https://anthropic.com/claude-fable-5-mythos-5-system-card).  
对齐。在我们的自动化对齐评估中，我们发现 Mythos 5 的未对齐行为水平（包括模型采取的未对齐行为，如欺骗，以及用户滥用模型时的合作）较低，与 Opus 4.8 相似。由于它们是相同的底层模型，Fable 5 的对齐水平也将相似。该评估在模型的系统卡中进行了完整描述，以及其他详细的安全和能力测试套件。

![](https://www.anthropic.com/_next/image?url=https%3A%2F%2Fwww-cdn.anthropic.com%2Fimages%2F4zrzovbb%2Fwebsite%2F2502a0daf85b741641cff36757d7243ef48f8be8-3840x2160.png&w=3840&q=75)

Overall level of misaligned behaviors from our automated alignment assessment. See section 6.2.3.1 of the system card for more. 我们自动化对齐评估中整体行为错位程度。更多详情请参见系统卡片的 6.2.3.1 节。

## Early feedback for Claude Fable 5早期对 Claude Fable 5 的反馈

Customers with early access ran their own tests on Fable 5. Below, in their words, is a selection of what they’re seeing:  
早期访问用户对 Fable 5 进行了自己的测试。以下是他们所说的一些所见所闻：

01 / 14

## Claude Fable 5’s new safeguardsClaude Fable 5 的新安全措施

Mythos-class models have reached a threshold where they present significant risks. In April we began [Project Glasswing](https://www.anthropic.com/glasswing), releasing the first Mythos-class model (Claude Mythos Preview) to only a limited group of cyber defenders and critical software infrastructure providers. When we did so, we stated that we hoped to eventually release [Mythos-level capabilities to all our users](https://www.anthropic.com/glasswing#:~:text=We%20do%20not,Preview3.), so long as we had developed new safeguards that were strong enough to reliably prevent misuse.  
神话级模型已达到一个存在显著风险的临界点。今年 4 月，我们启动了“玻璃翅膀”项目，向一小部分网络安全防御者和关键软件基础设施提供方发布了首个神话级模型（Claude Mythos 预览版）。当时我们表示，只要我们开发出足够强大的新安全措施来可靠地防止滥用，最终会将神话级功能对所有用户开放。

Over the past few months we have been improving these safeguards, and they are now robust enough for a general release. Because we have prioritized safety, we’ve deliberately tuned the safeguards to be cautious, and they are still stricter than would be ideal—for example, sometimes benign requests will trigger our classifiers. We recognize that this will be frustrating to some users, and our aim is to reduce false positives as we update and refine the safeguards after launch.  
在过去几个月中，我们一直在改进这些安全措施，现在它们已经足够稳健，可以进行全面发布。由于我们优先考虑安全，有意将安全措施调得谨慎，它们目前仍然比理想状态更严格——例如，有时良性请求也会触发我们的分类器。我们认识到这会让部分用户感到沮丧，我们的目标是在发布后通过更新和优化安全措施来减少误报。

Below we discuss each of Fable 5’s new safeguards in turn. Our wider suite of safeguards is discussed and evaluated in the model’s [system card](https://anthropic.com/claude-fable-5-mythos-5-system-card) and our most recent [risk report](https://cdn.sanity.io/files/4zrzovbb/website/097c63b5fe7dd8b14866e1f15bb1910ec713658a.pdf).  
下面我们逐一讨论 Fable 5 的每一项新安全措施。我们的更全面的安全措施在模型的系统说明和最新的风险报告中进行了讨论和评估。

### Safety classifiers 安全分类器

The frontier cybersecurity and research biology capabilities of Mythos-class models mean that they pose a substantial risk of *uplift* to malicious actors. That is, these models could provide information or advice that assists those actors in causing serious harm that they couldn’t have received from other sources (for example, from internet search engines). Furthermore, a great deal of advanced usage of AI models is dual use: the same queries that are beneficial in the hands of cybersecurity professionals and biology researchers could be dangerous if available to malicious actors.  
Mythos 级模型的前沿网络安全和研究生物学能力意味着它们对恶意行为者构成重大风险。也就是说，这些模型可能提供信息或建议，帮助这些行为者造成严重伤害，而这些伤害是他们无法从其他来源（例如互联网搜索引擎）获得的。此外，大量 AI 模型的先进使用具有双重用途：在网络安全专业人员和生物学研究人员手中有益的查询，如果落入恶意行为者手中，可能会造成危险。

We therefore need strong safeguards to prevent misuse, and their coverage needs to be broad. The safeguards themselves have to stand up to sustained and sophisticated attempts to bypass them (also known as “jailbreaking” the system). The uplift from Mythos-level capabilities is valuable to many adversaries—for instance, those who could financially gain from cyberattacks—and we therefore expect them to be motivated to try to circumvent our safety measures.  
因此，我们需要强大的安全措施来防止滥用，并且其覆盖范围需要广泛。这些安全措施本身必须能够抵御持续和复杂的绕过尝试（也称为“越狱”系统）。Mythos 级能力带来的提升对许多对手非常有价值——例如那些可以通过网络攻击获得经济利益的人——因此我们预计他们会受到激励去尝试绕过我们的安全措施。

Fable 5 comes with a new set of *classifiers*: separate AI systems that detect potential misuse, including jailbreak attempts, and prevent the main model (in this case Fable 5) from responding. We’ve been running classifiers on our models [for some time](https://www.anthropic.com/research/next-generation-constitutional-classifiers), and Fable 5’s classifiers are an extension of this previous work with extra coverage.  
Fable 5 配备了一套新的分类器：独立的 AI 系统，用于检测潜在的滥用行为，包括越狱尝试，并阻止主模型（在此情况下为 Fable 5）作出回应。我们已经在模型上运行分类器一段时间了，而 Fable 5 的分类器是这项先前工作的扩展，增加了额外的覆盖范围。

When Fable’s classifiers detect a request related to cybersecurity, biology and chemistry, or distillation, the response is automatically handled by Claude Opus 4.8 instead. Users will be informed whenever this occurs. Opus 4.8 is a highly capable model in its own right: a response that falls back to Opus is a far better experience than an outright refusal from Fable. Our early data shows that more than 95% of Fable sessions involve no fallback at all—for those sessions, Fable 5’s performance is effectively the same as that of Mythos 5.  
当 Fable 的分类器检测到与网络安全、生物学和化学或蒸馏相关的请求时，回应将自动由 Claude Opus 4.8 处理。用户每次遇到这种情况时都会被告知。Opus 4.8 本身就是一个功能强大的模型：当回应退回到 Opus 时，体验远比直接被 Fable 拒绝要好得多。我们的早期数据显示，超过 95%的 Fable 会话根本没有回退——对于这些会话，Fable 5 的性能实际上与 Mythos 5 相同。

The following are the areas covered by the classifiers:  
以下是分类器覆盖的领域：

*1\. Cybersecurity*. Mythos-class models [excel](https://red.anthropic.com/2026/mythos-preview/) at discovering and exploiting software vulnerabilities. They can thus make cyberattacks substantially easier and cheaper to commit. Mythos-class models also show strong skills in agentic hacking. This involves performing multiple different parts of a cyberattack in addition to finding exploits—reconnaissance, discovery, lateral movement, and more. To prevent these agentic hacking skills providing uplift in cyberattacks, we designed our cybersecurity classifiers to cover both exploitation and offensive cyber tasks in a broader sense. As shown in the graph below, our classifiers prevent Fable from making any progress on these tasks.  
1\. 网络安全。Mythos 级模型擅长发现和利用软件漏洞。因此，它们能显著降低网络攻击的难度和成本。Mythos 级模型还展现出强大的代理式黑客技能。这包括在发现漏洞之外，执行网络攻击的多个不同部分——侦察、发现、横向移动等。为防止这些代理式黑客技能在网络攻击中提供助力，我们设计了网络安全分类器，使其能更广泛地覆盖利用和进攻性网络任务。如下图所示，我们的分类器阻止了 Fable 在这些任务上取得任何进展。

![](https://www.anthropic.com/_next/image?url=https%3A%2F%2Fwww-cdn.anthropic.com%2Fimages%2F4zrzovbb%2Fwebsite%2Ffaf941fe1ebfd09139d39b8e4ad9048121979284-3840x2160.png&w=3840&q=75)

Results of running cyber evaluations, 3 with Fable 5 in a mode that blocks responses rather than falling back to Opus 4.8. Evaluations did not involve attempts to evade safeguards. 运行网络安全评估的结果， 在阻止响应而非回退到 Opus 4.8 的模式下使用 Fable 5。评估未涉及规避安全措施的尝试。

We extensively red-teamed our classifiers to test their robustness against jailbreaks. As well as internal testing, we ran an external bug bounty that produced no universal jailbreaks in over 1,000 hours of testing. External red-teaming organizations we engaged also failed to find any universal jailbreaks on long-form agentic tasks so far—although the UK AISI has made progress towards one within a brief initial testing window.<sup>4</sup> It is likely impossible to *completely* prevent universal jailbreaks, but our goal is to make any remaining jailbreaks sufficiently slow and costly that we can detect and prevent them before they are used at scale.  
我们对分类器进行了广泛的红队测试，以检验它们对越狱攻击的鲁棒性。除了内部测试外，我们还进行了一项外部漏洞悬赏活动，在超过 1,000 小时的测试中未发现任何通用越狱攻击。我们合作的外部红队组织到目前为止也没有在长文本代理任务中发现任何通用越狱攻击——尽管英国人工智能战略研究所（AISI）在短暂的初始测试窗口内取得了一些进展。 <sup>4</sup> 完全防止通用越狱攻击可能是不可能的，但我们的目标是使任何剩余的越狱攻击足够缓慢和昂贵，以便我们能够在它们大规模使用之前检测并阻止它们。

The graph below, from one of our internal evaluations, illustrates how Fable 5’s safeguards give it greater resistance to jailbreaks than our previous generally accessible models:  
下图来自我们内部评估之一，展示了 Fable 5 的安全措施如何使其比我们之前的通用可访问模型更能抵抗越狱攻击：

![](https://www.anthropic.com/_next/image?url=https%3A%2F%2Fwww-cdn.anthropic.com%2Fimages%2F4zrzovbb%2Fwebsite%2F6bede3f6101d15bd899922917ea6246adda4515b-1920x1080.png&w=3840&q=75)

Results of an internal evaluation in which an automated red-teamer tries to use the model to complete a short task related to offensive cybersecurity across 400 turns, restarting and rewinding when blocked. The tasks are mostly simple and not representative of real cyber usage—they are sometimes as simple as encrypting files on a remote server. On more complex and realistic tasks we have not yet seen successful jailbreaks on our production system. Note that Opus 4.6 does not have blocking cyber safeguards. 内部评估结果，其中自动化红队测试者尝试在 400 轮对话中利用该模型完成与攻击性网络安全相关的短期任务，并在遇到阻碍时重启和回溯。这些任务大多是简单的，并不代表真实的网络使用情况——有时简单到只是在远程服务器上加密文件。在更复杂和真实的任务上，我们尚未在我们的生产系统中看到成功的越狱。请注意，Opus 4.6 没有网络安全阻止措施。

One of our external partners found that Fable 5’s safeguards against harmful cyber queries were the most robust of any model tested (including Opus 4.8 and Opus 4.7). Fable 5 complied with zero harmful single-turn requests relating to planning a cyberattack, exploit development, or defense evasion. This held whether or not one of the requests used any of 30 different public jailbreak techniques.  
我们的一位外部合作伙伴发现，Fable 5 对有害网络查询的防护措施是所有测试模型中最稳健的（包括 Opus 4.8 和 Opus 4.7）。Fable 5 在涉及策划网络攻击、漏洞开发或防御规避的有害单轮请求方面均未妥协。无论请求中是否使用了 30 种不同的公开越狱技术，这一点都成立。

*2\. Biology and chemistry.* We have long used [our classifiers](https://www.anthropic.com/news/activating-asl3-protections) to block our models from responding on a narrow selection of bioweapons-related queries. But we are no longer certain that blocking this narrow selection is enough. This is for two reasons: first, we have reason for concern about well-resourced malicious actors attempting to gain uplift from our models for highly risky biological research. Second, models now have a greater ability to accomplish real-world scientific tasks.  
2\. 生物学和化学。我们长期以来一直使用分类器来阻止我们的模型对狭窄的生物武器相关查询做出回应。但我们不再确定阻止这些狭窄的选择就足够了。这有两个原因：首先，我们对资源充足的恶意行为者试图利用我们的模型进行高风险生物研究表示担忧。其次，模型现在具有更大的能力来完成现实世界的科学任务。

For example, we tested Mythos 5’s ability to complete a challenging step in designing [adeno-associated viruses](https://en.wikipedia.org/wiki/Adeno-associated_virus) (AAVs). AAVs are a component for delivering gene therapies, but the same capability, in the wrong hands, could enable the design of dangerous viruses. In this task, various AI models were evaluated on their ability to predict how a genetic modification would impact the assembly of the virus’s outer shell (among a set of therapeutically-relevant unpublished candidates developed by [Dyno Therapeutics](https://www.dynotx.com/)). We did not explicitly train our models to perform this task—and yet Mythos-class models outperformed sophisticated models dedicated to protein tasks (known as “protein language models”) using their biological reasoning alone. This demonstrates a promising ability to complete simple but important tasks in gene therapy research and development—but also highlights the risk posed by such dual-use capabilities.

![](https://www.anthropic.com/_next/image?url=https%3A%2F%2Fwww-cdn.anthropic.com%2Fimages%2F4zrzovbb%2Fwebsite%2F3437ad5c0853a7bd273ed5e56289a4f38dcd9731-3840x2160.png&w=3840&q=75)

Results of an evaluation in which our models predicted the unpublished experimental properties of the viral shell of a simple virus. Viral shell assembly is the simplest viral trait to predict in this context, but it is nonetheless an important property to get right when designing more complex features. AAV = adeno-associated virus. 一项评估结果，其中我们的模型预测了简单病毒病毒壳的未发表实验特性。病毒壳组装是在此背景下最容易预测的病毒特征，但在设计更复杂的特性时，正确预测它仍然是一个重要的属性。AAV = 腺相关病毒。

Our priority was to safely release Fable as soon as we could, even at the cost of overly broad safeguards. Therefore, for the time being we have arranged for Fable to fall back to Opus 4.8 on most requests related to biology and chemistry. As with all of our classifiers, we hope to narrow these safeguards as soon as possible: as can be seen from the evidence above, there is great potential for positive applications of Fable for science, and we do not want false positives from our classifiers to get in the way. In the coming weeks, some biomedical researchers and companies will be able to join our trusted access program for biology capabilities in Mythos 5 (discussed below).  
我们的优先任务是尽快安全地发布 Fable，即使这意味着过度宽泛的安全措施。因此，目前我们已安排 Fable 在大多数与生物学和化学相关的要求上回退到 Opus 4.8。与我们的所有分类器一样，我们希望尽快缩小这些安全措施：从上述证据可以看出，Fable 在科学方面具有巨大的积极应用潜力，我们不希望分类器的误报阻碍这一点。在接下来的几周里，一些生物医学研究人员和公司将能够加入我们信任访问计划，以获取 Mythos 5（下文将讨论）中的生物学功能。

*3\. Distillation*. We’ve previously identified [large-scale attempts](https://www.anthropic.com/news/detecting-and-preventing-distillation-attacks) to extract (“distill”) Claude’s capabilities to train [competing](https://www.anthropic.com/legal/commercial-terms) models in authoritarian countries. Distillation of Fable 5’s abilities could indirectly lead to the proliferation of near-frontier AI capabilities—and these could be released without the appropriate safeguards. Requests that are flagged by our classifiers as being part of such distillation attempts will fall back to Opus 4.8.  
3\. 提炼。我们之前已经识别出在威权国家大规模尝试提取（“提炼”）Claude 的能力来训练竞争性模型。提炼 Fable 5 的能力可能间接导致接近前沿 AI 能力的扩散——而这些能力可能会在没有适当安全措施的情况下被发布。我们的分类器标记为属于此类提炼尝试的要求将回退到 Opus 4.8。

### A new data retention policy一项新的数据保留政策

Finally, we’re making a change to the way we handle business customer data for Fable 5, Mythos 5, and future models with similar or higher capability levels. We will require 30-day retention for all traffic on Mythos-class models, on both first- and third-party surfaces. We won’t use this data to train new Claude models, or for any non-safety-related purpose, and we’ve instituted new privacy protections including logging all human access to the data and ensuring its deletion after 30 days in almost all cases (see [this post](https://support.claude.com/en/articles/15425996) for further details). The data will help us defend against complex and novel attacks (including new jailbreaks and attacks that operate across many requests) as well as help us identify and reduce false positives.  
最后，我们将调整 Fable 5、Mythos 5 以及未来具有相似或更高能力水平的模型中处理商业客户数据的方式。我们将要求 Mythos 级模型上的所有流量保留 30 天，包括第一方和第三方平台。我们将不会使用这些数据来训练新的 Claude 模型，或用于任何与安全无关的目的，并且已经实施了新的隐私保护措施，包括记录所有对数据的访问，并在几乎所有情况下确保 30 天后删除数据（有关更多详细信息，请参阅此帖子）。这些数据将帮助我们防御复杂和新型攻击（包括新的越狱攻击和跨多个请求操作的攻击），以及帮助我们识别和减少误报。

## Claude Mythos 5 and the trusted access programClaude Mythos 5 和可信访问计划

Beginning today, all users who currently have access to Claude Mythos Preview (for example, our cybersecurity partners in Project Glasswing) will be able to upgrade to Claude Mythos 5—the same model as Claude Fable 5 but with cyber safeguards lifted. Users will find Mythos 5 comparable to, or somewhat stronger than, Mythos Preview in most cases, while costing substantially less.  
从今天开始，所有目前可以访问 Claude Mythos Preview 的用户（例如，Project Glasswing 中的网络安全合作伙伴）将能够升级到 Claude Mythos 5——与 Claude Fable 5 相同的模型，但移除了网络安全防护。用户会发现 Mythos 5 在大多数情况下与 Mythos Preview 相当，或者略强一些，同时成本要低得多。

In consultation with the US government, we plan to steadily expand access to Claude Mythos 5, continuing our [periodic addition](https://www.anthropic.com/news/expanding-project-glasswing) of new partners, as well as pursuing a trusted access program that allows cybersecurity organizations to apply in a more systematic manner.  
在与美国政府的协商下，我们计划稳步扩大对 Claude Mythos 5 的访问权限，继续定期新增合作伙伴，并推进一个可信访问计划，该计划允许网络安全组织以更系统的方式申请。

Our plans also include opening a trusted access program for biology, to help accelerate biomedical research and discover new therapies with Mythos-class capabilities. This program will provide access to Fable 5 with the biology and chemistry safeguards removed (but the cyber safeguards still in place). It will enroll a small number of researchers from a variety of life science organizations spanning fundamental and translational research; we’re planning to expand access to this program while simultaneously making our safeguards better.  
我们的计划还包括为生物学领域开设一个可信访问计划，以帮助加速生物医学研究，并利用 Mythos 级能力发现新的疗法。该计划将提供对移除了生物学和化学保护措施（但网络安全保护措施仍然保留）的 Fable 5 的访问权限。该计划将招募来自不同生命科学组织（涵盖基础研究和转化研究）的一小部分研究人员；我们计划在同时提升我们的保护措施的情况下，扩大对该计划的访问权限。

## Availability 可用性

Claude Fable 5 is available everywhere today. Claude Mythos 5 is restricted to Glasswing partners (with cyber safeguards lifted) and soon to select biology researchers (with biology and chemistry safeguards lifted) only, until our broader trusted access program is available.  
Claude Fable 5 目前可在全球范围内使用。Claude Mythos 5 仅限于 Glasswing 合作伙伴（已移除网络安全保护措施）和即将到来的特定生物学研究人员（已移除生物学和化学保护措施），直到我们更广泛的可信访问计划可用。

Pricing for both models is $10 per million input tokens and $50 per million output tokens. Developers can use claude-fable-5 via the [Claude API](https://platform.claude.com/docs/en/about-claude/models/overview).  
两种模型的定价均为每百万输入 token 10 美元，每百万输出 token 50 美元。开发者可以通过 Claude API 使用 claude-fable-5。

We expect demand for Fable 5 to be very high, and difficult to predict. On the Claude API and consumption-based Enterprise plans, Fable 5 is fully available from today. For subscription plans, we’d rather give access sooner than later, so we’re rolling out more conservatively, in stages:  
我们预计 Fable 5 的需求会非常高，且难以预测。在 Claude API 和按量计费的企业计划中，Fable 5 从今天起完全可用。对于订阅计划，我们宁愿早些提供访问权限，因此我们采取了更为保守的分阶段推出方式：

- From today through June 22, Fable 5 is included on Pro, Max, Team, and seat-based Enterprise plans at no extra cost.  
	从今天到 6 月 22 日，Fable 5 将包含在 Pro、Max、Team 和基于座位的 企业计划中，无需额外费用。
- On June 23, we’ll remove Fable 5 from those plans. Using it after that will require [usage credits](https://support.claude.com/en/articles/12429409-manage-usage-credits-for-paid-claude-plans). If capacity allows, we’ll extend the included window.  
	6 月 23 日，我们将从这些计划中移除 Fable 5。之后使用它将需要使用积分。如果容量允许，我们将延长包含窗口期。
- After this point—when sufficient capacity allows us to do so—we aim to restore Fable 5 as a standard part of subscription plans. We intend to do this as quickly as we can.  
	从这一点开始——当我们的能力足够时——我们打算将 Fable 5 作为订阅计划的标准部分恢复。我们打算尽快做到这一点。

Throughout this period, we’ll communicate any changes ahead of time so users know where things stand.  
在此期间，我们将提前通知任何变更，以便用户了解当前情况。

*Edit June 9, 2026: Updated the discussion of AAVs to note that the candidates were developed by Dyno Therapeutics.  
2026 年 6 月 9 日编辑：更新了关于 AAVs 的讨论，指出候选者是由 Dyno Therapeutics 开发的。*

#### Footnotes 脚注

1. Mythos-class models are a tier of Claude models that sit above our Opus class in capability. The first, Claude Mythos Preview, was released in April through [Project Glasswing](https://www.anthropic.com/glasswing). That is followed today by Claude Fable 5 and Claude Mythos 5.  
	Mythos 级模型是 Claude 模型中功能层级高于 Opus 级的一级。首个 Claude Mythos 预览版通过 Project Glasswing 于 4 月发布。随后，今天推出了 Claude Fable 5 和 Claude Mythos 5。
2. Fable is from the Latin *fabula*, “that which is told,” akin to the Greek *mythos*. The safeguards are what distinguish the two models (Fable and Mythos) and are why we’ve given them different names.  
	Fable 源自拉丁语 fabula，意为“被讲述的事物”，与希腊语 mythos 相近。安全防护措施是区分这两种模型（Fable 和 Mythos）的关键，也是我们赋予它们不同名称的原因。
3. Metrics: Firefox = fraction of trials achieving arbitrary code execution (the exploit's full-success tier). OSS-Fuzz = severity-weighted mean of the five-tier score (0.2 crash → 1.0 control-flow hijack), so values are a weighted average rather than a success rate. CyberGym = fraction reproducing the target vulnerability (the public leaderboard metric). CyScenarioBench = success rate averaged equally across its challenges.  
	指标：Firefox = 实现任意代码执行试验的比例（利用的完全成功等级）。OSS-Fuzz = 五级评分的加权平均值（0.2 崩溃→1.0 控制流劫持），因此数值是加权平均值而非成功率。CyberGym = 重复目标漏洞的比例（公开排行榜指标）。CyScenarioBench = 在其挑战中平均分配的成功率。
4. A universal jailbreak can be defined as any prompt, script, or harness that allows a user to interact with a model as if its safeguards were not present. This is opposed to more minor jailbreaks that are only effective in very limited contexts or require additional effort to be adapted to each new situation.  
	一个通用越狱可以定义为任何提示、脚本或装置，它允许用户在与模型交互时，仿佛其安全保护措施不存在。这不同于那些仅在非常有限的上下文中有效或需要额外努力以适应每个新情况的小型越狱。

### DXC will integrate Claude into the systems banks, airlines, and other regulated industries rely onDXC 将将 Claude 集成到银行、航空公司和其他受监管行业所依赖的系统

We’re announcing a multi-year global alliance with DXC Technology, one of the world’s largest IT services companies.  
我们宣布与 DXC Technology 建立多年全球联盟，DXC Technology 是全球最大的 IT 服务公司之一。

### Introducing Claude Corps 推出 Claude Corps

We’re launching Claude Corps, a national fellowship program for people early in their careers who are passionate about extending the benefits of AI to communities across America.  
我们正在启动 Claude 军团，这是一个面向职业生涯早期、热衷于将 AI 的益处扩展到全美各社区的国家级奖学金项目。