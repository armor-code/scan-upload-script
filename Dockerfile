FROM python:alpine3.21

WORKDIR /app

COPY requirements.txt ./

RUN pip install --no-cache-dir -r requirements.txt

COPY script.py ./

CMD ["python", "script.py"]