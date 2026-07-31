---
title: "Subaru"
source: "https://www.cncf.io/case-studies/subaru/"
author:
  - "[[the numbers]]"
published: 2026-07-29
created: 2026-07-31
description: "Subaru Corporation is advancing AI research and development for next-generation EyeSight, further evolving “Preventive Safety,” one of the pillars of Subaru’s…"
tags:
  - "clippings"
---
## Subaru Accelerates AI Development for Next-Generation EyeSight with Kubernetes and CNCF Projects

### Executive Summary

Subaru Corporation is advancing AI research and development for next-generation EyeSight, further evolving “Preventive Safety,” one of the pillars of Subaru’s all-around safety philosophy. As the company works toward zero fatal traffic accidents in 2030,\[1\] Subaru is developing AI models in-house by combining its long-established stereo camera-based image recognition technology with AI to further improve recognition accuracy.

Supporting this work requires rapid, repeatable cycles of data processing, model training, artifact generation, and inference across an on-premises GPU environment. To enable these workflows at scale, Subaru built a Kubernetes-based AI model development platform powered by CNCF technologies.

By adopting Kubernetes together with Argo CD, Argo Workflows, Envoy Gateway, MetalLB, and Helm, Subaru improved platform performance, operational consistency, and reproducibility. One of the most significant results was reducing pull times for ML/CUDA container images larger than 30 GB from approximately three hours to approximately three minutes, dramatically accelerating AI development workflows.

By the numbers

60×

faster container image pulls

25

application definitions managed through GitOps

End-to-End

machine learning workflow automation

## Challenge

Developing AI models for next-generation EyeSight depends on fast, reproducible iterations of training and inference. Engineers continuously process large volumes of image data, train models, generate artifacts, and execute inference workloads to improve AI model accuracy.

As these workloads expanded, Subaru encountered three key challenges.

The first challenge was the growing size of machine learning container images. CUDA-based images frequently exceeded 30 GB, and in the previous environment, pulling images during pod startup could take more than three hours. These delays significantly slowed training and inference while making development cycles less predictable.

> “When image pulls took more than three hours, it was difficult for engineers to tell whether the system was still working normally or whether something had gone wrong.”
> 
> AI Development Team Member, Subaru Corporation

The second challenge centered on application deployment. Deployments relied on manually executed shell scripts that invoked Helm commands. While functional, this approach made deployment procedures difficult to standardize, limited declarative configuration management, and prevented adoption of GitOps practices. Teams also had to manually manage differences between development and production environments, increasing operational risk.

> “Deployment work depended on manual procedures, and the risk of deploying to the wrong environment, such as dev or production, had become an operational challenge.”
> 
> AI Development Team Member, Subaru Corporation

Finally, Subaru’s machine learning workflow consisted of numerous dependent stages, including data preparation, preprocessing, validation, training, model conversion, artifact storage, and downstream processing. The team needed a consistent way to orchestrate these processes, manage dependencies, improve reproducibility, and enable parallel execution where appropriate.

## Solution

To address these challenges, Subaru enhanced its Kubernetes-based AI model development platform by adopting multiple CNCF projects that accelerated container image delivery, standardized application delivery, and automated machine learning workflows.

### Accelerating Large Container Image Delivery

To improve delivery of large ML container images, Subaru adopted Harbor as its container registry and used Envoy Gateway with Gateway API-based routing to manage registry traffic.

To reduce networking overhead along the image pull path, Envoy Gateway was deployed in hostNetwork mode. Subaru also scheduled communicating workloads onto the same node whenever possible to keep traffic local. Combined with a MetalLB-based LoadBalancer configuration, this architecture created a more efficient network path and better utilized available network bandwidth, significantly improving image pull performance.

### Adopting GitOps with Argo CD

Subaru modernized application delivery by transitioning from manually executed Helm scripts to a GitOps workflow centered on Argo CD.

Using Argo CD together with Helmfile allowed the team to manage applications declaratively through Git while continuing to leverage existing Helm-based assets. This provided a consistent deployment model and improved operational reproducibility across environments.

### Automating Machine Learning Pipelines

To automate end-to-end machine learning workflows, Subaru adopted Argo Workflows.

Machine learning pipelines were defined as Kubernetes-native workflows, allowing dependencies between processing stages to be explicitly managed. Data preparation, validation, training, model conversion, artifact handling, and downstream processing could now be orchestrated through reproducible workflows while supporting more consistent execution across the platform.

## Impact

The most immediate improvement was the dramatic reduction in container image pull times.

By optimizing image delivery, Subaru reduced pull times for ML/CUDA container images larger than 30 GB from approximately three hours to approximately three minutes. Eliminating this bottleneck significantly accelerated pod startup, enabling engineers to begin training and inference workloads much sooner.

> “After the optimization, large ML/CUDA images could be pulled in approximately three minutes. The difference was dramatic, and it immediately changed the development experience.”
> 
> AI Development Team Member, Subaru Corporation

GitOps adoption also improved operational consistency.

By managing application definitions in Git using Argo CD and Helmfile, Subaru reduced manual deployment procedures while improving reproducibility across Kubernetes environments. Today, the team manages 25 application definitions through GitOps and deploys them using Argo CD.

> “Achieving GitOps had been a long-standing goal for our team. Moving from manually executed Helm scripts to Git-based declarative management was a major milestone, helping us improve deployment reproducibility, consistency, and ease of operation.”
> 
> AI Development Team Member, Subaru Corporation

Argo Workflows strengthened Subaru’s machine learning development process by automating complex multi-step pipelines. Explicit workflow dependencies reduced manual intervention while providing a stronger foundation for reproducible AI model development.

The platform also made it easier for engineering teams to continuously execute GPU-based training workloads and operate those workloads more consistently throughout the AI development lifecycle.

## Future Plans

Subaru plans to continue evolving its Kubernetes-based AI model development platform.

Areas under consideration include:

- Supporting multi-node distributed training workloads using a high-bandwidth secondary network.
- Exploring deployment automation for edge environments.

Through these efforts, Subaru aims to further improve automation, reproducibility, and operational efficiency across the AI model development lifecycle.

## Footnote

**\[1\]** Aim for zero fatal traffic accidents among occupants of Subaru vehicles and people involved in collisions with Subaru vehicles, including pedestrians and cyclists.