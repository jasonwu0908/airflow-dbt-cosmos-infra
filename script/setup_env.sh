#!/bin/bash

export AIRFLOW_VERSION=2.10.0
export PYTHON_VERSION="$(uv run python --version | cut -d " " -f 2 | cut -d "." -f 1-2)"
export CONSTRAINT_URL="https://raw.githubusercontent.com/apache/airflow/constraints-${AIRFLOW_VERSION}/constraints-${PYTHON_VERSION}.txt"


echo "AIRFLOW_HOME: $AIRFLOW_HOME"
echo "AIRFLOW_VERSION: $AIRFLOW_VERSION"
echo "PYTHON_VERSION: $PYTHON_VERSION"
echo "CONSTRAINT_URL: $CONSTRAINT_URL"