FROM debian:stable-slim

WORKDIR /usr/src/app

COPY . .

RUN apt-get update && apt-get install -y \
    make build-essential libssl-dev zlib1g-dev libbz2-dev \
    libreadline-dev libsqlite3-dev wget curl llvm \
    libncurses5-dev xz-utils tk-dev \
    libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev \
    && curl https://pyenv.run | bash \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

ENV HOME /root
ENV PYENV_ROOT $HOME/.pyenv
ENV PATH $PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH

RUN pyenv install 3.10.13 \
    && pyenv global 3.10.13 \
    && python -m pip install --upgrade pip && pip install --no-cache-dir -r requirements.txt

ENV AWS_ACCESS_KEY_ID=access_key
ENV AWS_SECRET_ACCESS_KEY=secret_key
ENV BACKEND_URI sqlite:///mlflow.db
ENV ARTIFACT_ROOT s3://bucket_name/mlflow/

WORKDIR ./myapp

EXPOSE 5000

CMD mlflow server --backend-store-uri $BACKEND_URI --default-artifact-root $ARTIFACT_ROOT --host 0.0.0.0