# Argo CD Applications (App-of-Apps)

This directory defines Argo CD `Application` resources that manage all MaxPower platform components in the development environment.

## Applications
- `cockroachdb-dev`: Bootstraps CockroachDB (logical DB creation handled by Job in kustomization).
- `pim-backend-dev`: PIM backend API (runs Prisma migrations via PreSync hook Job).
- `web-content-dev`: Web content API (Prisma migrations via PreSync hook Job).
- `web-admin-frontend-dev`: Admin UI.
- `maxpower-frontend-dev`: Public-facing UI.

## Expected Branching
Each Application targets the `development` branch of its respective configuration repo and the `overlays/dev` path (or `cockroachdb` for infra). Update `targetRevision` if you use tags or version branches later.

## Sync Policy
All Applications use automated sync with `prune` and `selfHeal` plus `CreateNamespace=true` to avoid manual namespace creation. Disable these options in production if you want stricter change control.

## Adding a New Service
1. Create a new config repo with `base/` and `overlays/dev/`.
2. Add Kustomize manifests (Deployment, Service, optional Jobs).
3. Add a new `Application` YAML here pointing to the repo/path.
4. Commit & push; Argo CD will pick it up after syncing this infra repo.

## Rollout Flow
1. Commit infra and service config changes to `development`.
2. Push repos.
3. Argo CD syncs `cockroachdb-dev` (ensures DB prepared) and each service Application independently.
4. Backends run migrations (PreSync Job) before Deployment sync wave.
5. Frontends deploy static containers.

## Notes
- Secrets are currently placeholders; integrate SealedSecrets or ExternalSecrets before storing sensitive values.
- Image tags are `dev` placeholders; update or automate tagging via CI later.
- If you need ordering across Applications (e.g., DB before backends), rely on readiness checks or add an App-of-Apps umbrella with sync waves.
