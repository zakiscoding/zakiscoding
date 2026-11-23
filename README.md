<a href="https://zakariye-mohamed.vercel.app"><img src="assets/banner.svg" alt="Zakariye Mohamed: AI, systems and infrastructure engineer" width="100%"></a>

<div align="center">

[![Typing SVG](https://readme-typing-svg.demolab.com?font=Fira+Code&weight=500&size=19&duration=3500&pause=1200&color=58A6FF&center=true&vCenter=true&width=720&lines=Distributed+schedulers+%C2%B7+matching+engines+%C2%B7+GPU+kernels;RAG+and+LLM+apps+built+to+run+fast;Systems+Engineer+Intern+%40+InComm+Payments;Ex-IBM+SRE+Intern+%C2%B7+Signify+%C2%B7+Crescent+AI)](https://github.com/zakiscoding)

<a href="https://zakariye-mohamed.vercel.app"><img src="https://img.shields.io/badge/Portfolio-1F6FEB?style=for-the-badge&logo=vercel&logoColor=white" /></a>
<a href="https://linkedin.com/in/zakariye-mohamed"><img src="https://img.shields.io/badge/LinkedIn-30363D?style=for-the-badge&logo=linkedin&logoColor=white" /></a>
<img src="https://img.shields.io/badge/Atlanta,_GA-161B22?style=for-the-badge&logo=googlemaps&logoColor=white" />

</div>

<img src="assets/divider.svg" alt="" width="100%">

## About

<img src="assets/whoami.svg" alt="whoami: Georgia State B.S. Computer Science 2023 to 2027; Systems Engineer Intern at InComm Payments; AI/ML Fellow at Cornell Tech and Break Through Tech; building a GPU-aware job scheduler" width="100%">

## Experience

| Where | What I did |
|---|---|
| **InComm Payments**<br><sub>Systems Engineer Intern · Sep 2026 – Now</sub> | SFTP batch-platform migration and client onboarding · failure alerts for enterprise file workflows |
| **Cornell Tech × Break Through Tech**<br><sub>AI/ML Fellow · Apr 2026 – Now</sub> | Neural nets, RAG and multimodal LLMs · applied ML pipelines with an industry partner |
| **IBM**<br><sub>SRE Intern · May – Aug 2026</sub> | Sentinel ops dashboard (React/Django/PostgreSQL) for 50+ engineers · correlation-ID tracing · Terraform/Terragrunt |
| **Signify**<br><sub>Software Engineer Intern · Jan – May 2026</sub> | Hybrid on-prem/AWS/Azure environment · CI/CD work that cut build time 40% · BLE Mesh lighting |
| **Crescent Technology**<br><sub>AI Engineer Intern · Jul – Dec 2025</sub> | RAG pipeline cut hallucinations 80% · latency 11–13 s → under 4 s · ~20% fewer tokens |

## Featured Projects

<table>
<tr>
<td width="50%" valign="top">
<a href="https://github.com/zakiscoding/gophergrid"><img src="assets/projects/gophergrid.svg" alt="gophergrid: distributed job scheduler in Go and Rust" width="100%"></a>
<br><sub>Distributed job scheduler in Go + Rust: etcd leader election, GPU-aware placement, heartbeat leases, and exactly-once results with fencing tokens. Chaos tests kill workers and the leader.</sub>
</td>
<td width="50%" valign="top">
<a href="https://github.com/zakiscoding/limit-order"><img src="assets/projects/limit-order.svg" alt="limit-order: C++ matching engine" width="100%"></a>
<br><sub>Price/time matching engine with deterministic replay and UDP market-data ingestion. Profiling showed the order-ID index ate half the cycles; replacing it took throughput from 12.4M to 17.2M events/s.</sub>
</td>
</tr>
<tr>
<td width="50%" valign="top">
<a href="https://github.com/zakiscoding/gpu-systems-lab"><img src="assets/projects/gpu-lab.svg" alt="gpu-systems-lab: CUDA and NCCL experiments" width="100%"></a>
<br><sub>CUDA, NCCL and MPI experiments on a local RTX 5070 and cloud H100s: a warp-shuffle reduction at ~625 GB/s (93% of DRAM peak) and NCCL all-reduce at 344 GB/s on 2× H100.</sub>
</td>
<td width="50%" valign="top">
<a href="https://kash-nine.vercel.app"><img src="assets/projects/kash.svg" alt="Kash: live AI finance tracker" width="100%"></a>
<br><sub>Live AI finance tracker: Gemini receipt scanning, budget alerts, recurring transactions and AI monthly reports by email. <a href="https://github.com/zakiscoding/Kash">Code</a> · <a href="https://kash-nine.vercel.app">Live</a></sub>
</td>
</tr>
<tr>
<td width="50%" valign="top">
<a href="https://github.com/zakiscoding/homelab"><img src="assets/projects/homelab.svg" alt="homelab: self-hosted ML platform" width="100%"></a>
<br><sub>Self-hosted ML platform on k3s: Postgres job queue with leases and retries, Qdrant RAG, Prometheus/Grafana and MLflow, shipped as an 11-service Helm chart via Argo CD.</sub>
</td>
<td width="50%" valign="top">
<a href="https://github.com/zakiscoding/redis-clone"><img src="assets/projects/redis.svg" alt="redis-clone: Redis-compatible server in C" width="100%"></a>
<br><sub>Redis-compatible server in C: RESP protocol, nonblocking event loop, and an append-only log that recovers cleanly from torn writes.</sub>
</td>
</tr>
</table>

<details>
<summary><b>More projects</b></summary>
<br>

- **[QuickBite](https://github.com/zakiscoding/AI-FoodDelivery-App)** · [live](https://team-sleep-liart.vercel.app): team food-delivery app with an AI ordering assistant (Next.js, Supabase, OpenAI)
- **[Multimodal Emotion AI](https://github.com/zakiscoding/EMOTION-Multimodal-AI-Model)**: video + audio + text late-fusion model on MELD, trained and served on SageMaker
- **[Audio CNN](https://github.com/zakiscoding/Audio_CNN)** · [live](https://audio-cnn-saas.vercel.app): residual CNN on ESC-50, 78.5% validation accuracy
- **[Housing MLOps](https://github.com/zakiscoding/Housing-Regression-Model)**: XGBoost + Optuna + MLflow, two services on ECS Fargate via GitHub Actions
- **[Low-Latency Trading Engine](https://github.com/zakiscoding/low-latency-trading-engine)**: C++ engine on live market data with paper trading
- **[Kubernetes CI/CD](https://github.com/zakiscoding/amazon-prime)**: Jenkins → SonarQube → Trivy → ECR → EKS with Argo CD

</details>

## Tech Stack

<p align="center">
  <img src="https://skillicons.dev/icons?i=python,cpp,c,go,rust,ts,java,bash&theme=dark&perline=8"><br>
  <img src="https://skillicons.dev/icons?i=pytorch,tensorflow,aws,azure,gcp,docker,kubernetes,terraform&theme=dark&perline=8"><br>
  <img src="https://skillicons.dev/icons?i=nextjs,react,nodejs,fastapi,postgres,redis,grafana,githubactions&theme=dark&perline=8">
</p>

<p align="center"><sub>Also: CUDA · NCCL · vLLM · Hugging Face · LangChain · MLflow · Qdrant · gRPC · etcd · Helm · Argo CD · Prometheus · OpenShift</sub></p>

<img src="assets/divider.svg" alt="" width="100%">
