from prometheus_client import make_asgi_app, Histogram, Counter, Gauge

metrics_app = make_asgi_app()

_BUCKETS = [0.01, 0.02, 0.05, 0.1, 0.2, 0.5, 1.0]

E2E_GENERATE_LATENCY = Histogram(
    name="lmdeploy:e2e_generate_latency_seconds",
    documentation="Histogram of end to end generate latency in seconds",
    labelnames=["model_name", "mode"],
    buckets=_BUCKETS
)

E2E_REQUEST_LATENCY = Histogram(
    name="lmdeploy:e2e_request_latency_seconds",
    documentation="Histogram of end to end request latency in seconds.",
    labelnames=["model_name", "mode"],
    buckets=_BUCKETS
)

GENERATED_TOKENS_COUNT = Counter(
    name="lmdeploy:generation_tokens_total",
    documentation="Number of generation tokens processed.",
    labelnames=["model_name"],
)

PROMPT_TOKENS_COUNT = Counter(
    name="lmdeploy:prompt_tokens_total",
    documentation="Number of prompt tokens processed.",
    labelnames=["model_name"]
)

FINISH_REASON_COUNT = Counter(
    name="lmdeploy:request_success_total",
    documentation="Number of requests finished with success.",
    labelnames=["model_name", "finished_reason"]
)

REQUEST_STATUS_GAUGE = Gauge(
    name="lmdeploy:request_status",
    documentation="Number of requests in special status.",
    labelnames=["model_name", "status"]
)
