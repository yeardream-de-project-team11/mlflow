#!/bin/bash
mlflow server --backend-store-uri $BACKEND_URI --default-artifact-root $ARTIFACT_ROOT --host 0.0.0.0
