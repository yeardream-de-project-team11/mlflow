#!/bin/bash
mlflow models serve -m runs:/${MODEL_RUN_ID}/model -p 5000 --host 0.0.0.0