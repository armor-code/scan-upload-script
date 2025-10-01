FROM alpine:latest

# Install Python and pip
RUN apk add --no-cache python3 py3-pip

# Create user and group
RUN addgroup -g 1001 appgroup && adduser -D -u 1001 -G appgroup 1001

WORKDIR /app

# Create virtual environment
RUN python3 -m venv /app/venv

# Copy requirements
COPY requirements.txt ./

# Install packages in venv
RUN /app/venv/bin/pip install --no-cache-dir -r requirements.txt

COPY script.py ./

USER 1001

# Use python from venv
CMD ["/app/venv/bin/python", "script.py"]