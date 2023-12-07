FROM python:3.10.13-slim

WORKDIR /usr/src/app

COPY . .

RUN python -m pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

WORKDIR ./myapp

ENV AWS_ACCESS_KEY=access_key
ENV AWS_SECRET_KEY=secret_key
ENV BACKEND_URI sqlite:///mlflow.db
ENV ARTIFACT_ROOT s3://bucket_name/mlflow/

EXPOSE 5000

CMD mlflow server --backend-store-uri $BACKEND_URI --default-artifact-root $ARTIFACT_ROOT --host 0.0.0.0
