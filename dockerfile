FROM python:3.8-slim
WORKDIR /app
COPY . /app
COPY app.py /app
RUN pip install -r requirements.txt
ENTRYPOINT ["python", "app.py"]