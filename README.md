# Xoloforge - (CV Platform — AI-Powered Career Tools)

Like the Xolo dog who guided souls through Mictlán, Xoloforge guides you through the modern job search. An AI-powered career platform featuring a CV builder, intelligent CV scoring, and a multi-agent job scout — built production-grade on Kubernetes and AWS, and architected from day one for multi-cloud scale and potential commercialization.

A production-ready, multi-environment platform for building, improving, scoring, and scouting job opportunities using a self-hosted LLM on Kubernetes.

## Architecture

```
Ingress (NGINX)
├── /builder        → svc/cv-builder       → deployment/cv-builder
├── /improvement    → svc/cv-improvement   → deployment/cv-improvement (+ scoring sidecar)
└── /scout          → svc/multi-agent-scout → deployment/multi-agent-scout

Internal (ClusterIP only)
├── svc/llm-server  → deployment/llm-server  (Ollama / vLLM — model-agnostic)
└── svc/mcp-server  → deployment/mcp-server  (LinkedIn MCP Server)
```

### Services

| Service | Description | Owner |
|---|---|---|
| `cv-builder` | Upload a CV, get a structured, LLM-enhanced version | App |
| `cv-improvement` | Score a CV and receive actionable improvement suggestions | App |
| `multi-agent-scout` | CrewAI pipeline: Agent 1 analyzes CV → Agent 2 scouts LinkedIn jobs | App |
| `mcp-server` | LinkedIn MCP server, internal only | App |
| `llm-server` | Self-hosted Ollama/vLLM endpoint, internal only | Infra |

### Tech Stack

- **Cloud**: AWS (EKS, ECR, VPC, Secrets Manager, IAM)
- **IaC**: Terraform (modular, per-environment)
- **Container Orchestration**: Kubernetes + Kustomize (base + overlays)
- **CI/CD**: GitHub Actions (Gitflow — feature → develop → main)
- **App Framework**: FastAPI (Python)
- **AI Orchestration**: CrewAI (multi-agent scout)
- **Model Serving**: Ollama (dev) / vLLM (staging, prod)
- **Model**: GPT-oss 120B / Qwen 3.5 (configurable per environment)

## Environments

| Environment | Branch | Purpose |
|---|---|---|
| `dev` | `develop` | Active development, lightweight node groups |
| `staging` | `release/*` | Pre-prod validation, mirrors prod config |
| `prod` | `main` | Production, GPU node groups enabled |

## Repository Structure

```
.
├── .github/
│   ├── workflows/          # CI/CD pipelines
│   └── PULL_REQUEST_TEMPLATE/
├── docs/                   # Architecture diagrams, ADRs
├── k8s/
│   ├── base/               # Kustomize base manifests per service
│   └── overlays/           # Per-environment patches (dev/staging/prod)
├── services/               # Application source code
│   ├── cv-builder/
│   ├── cv-improvement/
│   ├── multi-agent-scout/
│   └── mcp-server/
└── terraform/
    ├── modules/            # Reusable Terraform modules
    └── environments/       # Per-environment root modules
```

## Getting Started

See [CONTRIBUTING.md](./CONTRIBUTING.md) for the full development workflow.

### Prerequisites

- Docker + Docker Compose
- Ollama (for local LLM inference)
- Python 3.11+
- `kubectl`, `terraform`, `aws-cli` (for infra work)

### Local Development (per service)

```bash
cd services/<service-name>
cp .env.example .env
docker compose up
```

Each service exposes a local Swagger UI at `http://localhost:800X/docs`.

## Deployment

> ⚠️ Deployment pipelines are fully configured but require AWS credentials and an initialized Terraform state backend. See `terraform/environments/` for setup instructions.

```bash
# Infra (run once per environment)
cd terraform/environments/dev
terraform init
terraform plan

# K8s (applied by CI/CD on merge)
kubectl apply -k k8s/overlays/dev
```

## Contributors

| Name | Role |
|---|---|
| [Your Name] | Platform Engineer — Terraform, K8s, CI/CD |
| [Friend's Name] | Application Engineer — Services, AI agents |
