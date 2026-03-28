# Contributing Guide

This document covers the full development workflow for this project. Read it before opening your first PR.

---

## Branching Strategy — Gitflow

We follow [Gitflow](https://nvie.com/posts/a-successful-git-branching-model/). Here's what that means in practice:

```
main          ← production-ready code only. Never commit directly.
develop       ← integration branch. All features merge here first.
feature/*     ← your daily work branch. Branch off develop.
release/*     ← created from develop when preparing a release.
hotfix/*      ← emergency fixes branched off main.
```

### Starting a new task

```bash
# Always branch from develop
git checkout develop
git pull origin develop
git checkout -b feature/your-task-name
```

**Branch naming conventions:**

| Type | Pattern | Example |
|---|---|---|
| Feature | `feature/<short-description>` | `feature/cv-builder-pdf-parsing` |
| Bug fix | `fix/<short-description>` | `fix/scoring-null-pointer` |
| Infra | `infra/<short-description>` | `infra/eks-gpu-nodegroup` |
| Docs | `docs/<short-description>` | `docs/architecture-diagram` |
| Release | `release/<version>` | `release/1.0.0` |
| Hotfix | `hotfix/<short-description>` | `hotfix/mcp-auth-failure` |

---

## Pull Request Rules

- **All PRs target `develop`**, not `main`
- PRs to `main` are only opened from `release/*` branches
- At least **1 reviewer approval** required before merge
- All CI checks must pass (lint, test, build)
- No direct pushes to `main` or `develop` — enforced by branch protection

### PR Title Format

```
[type] short description

Examples:
[feature] Add PDF parsing to cv-builder
[infra] Add EKS GPU node group Terraform module
[fix] Handle empty CV upload in cv-improvement
```

### PR Description

Use the PR template in `.github/PULL_REQUEST_TEMPLATE/pull_request_template.md`.
Fill it out fully — it exists to make reviews faster, not slower.

---

## Commit Message Format

We follow [Conventional Commits](https://www.conventionalcommits.org/):

```
<type>(<scope>): <short description>

Types: feat, fix, infra, docs, test, refactor, chore
Scope: cv-builder | cv-improvement | scout | mcp | k8s | terraform | ci

Examples:
feat(cv-builder): add structured JSON output from LLM
infra(terraform): add VPC module with public/private subnets
fix(cv-improvement): handle missing skills field in scoring sidecar
test(cv-builder): add unit tests for PDF extraction
```

---

## Local Development Setup

### Prerequisites

- Python 3.11+
- Docker + Docker Compose
- [Ollama](https://ollama.com) for local LLM inference

### Running a service locally

Each service has its own `docker-compose.yml` that spins up the FastAPI app + a local Ollama instance.

```bash
cd services/cv-builder      # or any other service
cp .env.example .env        # fill in any required values
docker compose up           # starts the service + ollama
```

Swagger UI: `http://localhost:800X/docs` (port varies per service — see each service's README)

### Running tests

```bash
cd services/cv-builder
pip install -r requirements-dev.txt
pytest tests/ -v
```

---

## Environment Variables

Never commit `.env` files or secrets. Use `.env.example` as the template.

Secrets in deployed environments are managed via **AWS Secrets Manager + External Secrets Operator**. If you need a new secret, flag it in your PR description and the infra engineer will provision it.

---

## CI/CD Overview

GitHub Actions runs automatically on every push and PR:

| Trigger | Pipeline | What it does |
|---|---|---|
| Push to any `feature/*` | `lint-test.yml` | Lint + unit tests |
| PR to `develop` | `lint-test.yml` + `build.yml` | Lint, test, Docker build |
| Merge to `develop` | `deploy-dev.yml` | Build, push to ECR, deploy to `dev` |
| Merge to `release/*` | `deploy-staging.yml` | Deploy to `staging` |
| Merge to `main` | `deploy-prod.yml` | Deploy to `prod` (requires manual approval) |

> ⚠️ The deploy pipelines require AWS credentials configured as GitHub Actions secrets. If you're working on app code only, the lint + test pipeline is what you'll see on your PRs.

---

## Questions?

Open a GitHub Discussion or ping the platform engineer before starting any task that touches infra, K8s manifests, or CI/CD files.
