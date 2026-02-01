# 使用官方 Airflow 映像檔作為基底
FROM apache/airflow:2.10.0-python3.11

USER root

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

USER airflow

COPY --chown=airflow:root airflow/dags/dbt/requirements.txt /opt/airflow/dbt-requirements.txt

ENV DBT_VENV_PATH="${AIRFLOW_HOME}/dbt_venv"
RUN python -m venv "${DBT_VENV_PATH}"
RUN ${DBT_VENV_PATH}/bin/pip install --no-cache-dir -r /opt/airflow/dbt-requirements.txt


# 2. 安裝 Airflow 端的依賴 (包含 Cosmos)
COPY --chown=airflow:root requirements.txt /opt/airflow/requirements.txt
RUN pip install --no-cache-dir -r /opt/airflow/requirements.txt
