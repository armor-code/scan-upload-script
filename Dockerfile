FROM alpine:latest

# Update, upgrade, and install dependencies
# Explicitly upgrade openssl packages to fix CVE-2025-15467
# Require python3 >= 3.14.10-r0 to fix CVE-2026-115557 (build fails if unavailable)
RUN apk update && \
    apk upgrade --no-cache && \
    apk --update --no-cache add 'python3>=3.14.10-r0' py3-pip openssl && \
    apk upgrade --no-cache libcrypto3 libssl3 openssl && \
    python3 -m venv /usr/src/venv && \
    /usr/src/venv/bin/pip install --upgrade pip && \
    apk del py3-pip

# Create user and group
RUN addgroup -g 1001 appgroup && adduser -D -u 1001 -G appgroup 1001

WORKDIR /app

# Copy requirements
COPY requirements.txt ./

# Install packages in venv
RUN /usr/src/venv/bin/pip install --no-cache-dir -r requirements.txt && \
    rm -rf /usr/src/venv/lib/python*/site-packages/pip* && \
    rm -rf /usr/src/venv/lib/python*/site-packages/setuptools* && \
    find /usr/src/venv/bin -name 'pip*' -delete

COPY script.py ./

USER 1001

# Use python from venv
CMD ["/usr/src/venv/bin/python", "script.py"]