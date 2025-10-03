FROM alpine:latest

# Update, upgrade, and install dependencies
RUN apk update && \
    apk upgrade && \
    apk --update --no-cache add python3 py3-pip openssl && \
    python3 -m venv /usr/src/venv && \
    /usr/src/venv/bin/pip install --upgrade pip && \
    apk del py3-pip

# Create user and group
RUN addgroup -g 1001 appgroup && adduser -D -u 1001 -G appgroup 1001

WORKDIR /app

# Copy requirements
COPY requirements.txt ./

# Install packages in venv
RUN /usr/src/venv/bin/pip install --no-cache-dir -r requirements.txt

COPY script.py ./

USER 1001

# Use python from venv
CMD ["/usr/src/venv/bin/python", "script.py"]