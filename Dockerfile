FROM python:3.10.13-slim

WORKDIR /usr/src/app

COPY . .

RUN apt-get update && apt-get install -y \
    make build-essential libssl-dev zlib1g-dev libbz2-dev \
    libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
    xz-utils tk-dev \
    && git clone https://github.com/pyenv/pyenv.git $HOME/.pyenv \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

ENV PYENV_ROOT="$HOME/.pyenv"
ENV PATH="$PYENV_ROOT/bin:$PATH"
ENV PYENV_INIT="eval \"$(pyenv init -)\""

RUN python -m pip install --upgrade pip \
    && pip install --no-cache-dir -r requirements.txt

ENV AWS_ACCESS_KEY_ID=access_key
ENV AWS_SECRET_ACCESS_KEY=secret_key
ENV BACKEND_URI sqlite:///mlflow.db
ENV ARTIFACT_ROOT s3://bucket_name/mlflow/

WORKDIR ./myapp

EXPOSE 5000

CMD mlflow server --backend-store-uri $BACKEND_URI --default-artifact-root $ARTIFACT_ROOT --host 0.0.0.0
