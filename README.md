# Platform Infra (Demo)

This repository houses cluster-level primitives and shared infrastructure manifests consumed by Argo CD.

Contents (initial minimal set):
- `cockroachdb/` – Single-node CockroachDB for dev/test plus bootstrap job creating logical databases & roles.

## Logical Databases
Provisioned here (idempotent bootstrap job):
- `app_db` – Owned by PIM backend (product/catalog domain)
- `web_content_db` – Owned by web-content API (CMS/content domain)

Future additions (e.g. `auth_db`) extend the bootstrap SQL only—service config repos remain unchanged.

## Separation of Concerns
- DB cluster (statefulset/service/namespace) lives only here.
- Per-service schema migrations live in their SOURCE repos and are executed via PreSync Job defined in each *config* repo.
- No schema tables are defined in this infra repo aside from initial logical DB + roles.

## Argo CD Usage
Point an Argo CD Application at `platform-infra-demo/cockroachdb` (or an overlay you create later) to deploy the cluster and bootstrap job. Ensure sync waves allow the DB to be ready before backend migration jobs run.

## Next Steps (Optional)
- Replace single-node with multi-node StatefulSet for HA.
- Introduce SealedSecrets for role credentials.
- Add monitoring stack (Prometheus/Grafana) and external access (Ingress) as needed.