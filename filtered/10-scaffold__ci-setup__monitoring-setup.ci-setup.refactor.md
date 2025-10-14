```md
# Monitoring Setup

Trigger: /monitoring-setup

Purpose: Bootstrap logs, metrics, and traces with dashboards per domain.

**Steps:**

1. Choose stack: OpenTelemetry → Prometheus/Grafana, or vendor.
2. Instrument web and api for request latency, error rate, throughput, and core domain metrics.
3. Provide default dashboards JSON and alert examples.

**Output format:** instrumentation checklist and dashboard links/paths.

**Examples:** `/monitoring-setup`.

**Notes:** Avoid high‑cardinality labels. Sample traces selectively in prod.

Respond with the corresponding output fields, starting with the field `[[ ## reasoning ## ]]`, then `[[ ## template_markdown ## ]]`, and then ending with the marker for `[[ ## completed ## ]]`.
```
