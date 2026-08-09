# Vision service

E01-05 adds a Python 3.12/FastAPI Local/CI contract stub.

It exposes versioned liveness and readiness endpoints plus a strict authenticated analysis contract that always returns `501 Not Implemented`. It downloads no model, accepts no image, stores no state, starts no queue, and makes no operational or municipal decision.

See [local vision operations](../../docs/operations/local-vision.md) for setup, tests, safe configuration, endpoints, and evidence limitations.
