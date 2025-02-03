FROM python:alpine3.21

RUN addgroup -g 1001 appgroup && adduser -D -u 1001 -G appgroup 1001

WORKDIR /app

COPY requirements.txt ./

RUN pip install --no-cache-dir -r requirements.txt

COPY script.py ./

USER 1001

CMD ["python", "script.py"]