from datetime import datetime
from pathlib import Path

from cosmos import (
    DbtDag,
    ProjectConfig,
    ProfileConfig,
    ExecutionConfig,
    RenderConfig,
    LoadMode
)
from cosmos.profiles import PostgresUserPasswordProfileMapping


DBT_ROOT_PATH = Path(__file__).parent.parent / "dbt"
dbt_executable_path = DBT_ROOT_PATH.parent.parent / "dbt_venv/bin/dbt"


cosmos_postgres = DbtDag( 
    project_config=ProjectConfig( 
        dbt_project_path=DBT_ROOT_PATH / "my_postgres",
        manifest_path=DBT_ROOT_PATH / "my_postgres/target/manifest.json",
        install_dbt_deps=False,
    ),
    profile_config=ProfileConfig( 
        profile_name="default", 
        target_name="dev",
        profile_mapping=PostgresUserPasswordProfileMapping( 
            conn_id="local_postgres", 
            profile_args={"schema": "public"},
        ),
    ),
    execution_config=ExecutionConfig(
        dbt_executable_path=dbt_executable_path,
    ),
    render_config=RenderConfig(
        load_method=LoadMode.DBT_MANIFEST,
    ),
    # normal dag parameters
    schedule="@daily", 
    start_date=datetime(2025, 1, 1), 
    catchup=False, 
    dag_id="cosmos_postgres", 
    default_args={"retries": 2}, 
)
