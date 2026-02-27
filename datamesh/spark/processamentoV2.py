import sys
import logging
import traceback
from pyspark.sql import functions as F 
from awsglue.context import SparkContext
from datetime import datetime, timedelta
from awsglue.utils import getResolvedOptions


def load_and_register_table(glue_context, table_config, partition_predicate):
    table_name = table_config["table_name"]
    columns = table_config["columns"]
    database = table_config["database"]

    yar_str = str(partition_predicate[0]).zfill(2)

    try:
        dynamic_frame glue_context.create_dynamic_frame.from_catalog(
            database=database,
            table_name=table_name,
            push_down_predicate=partition_predicate,
            additional_options={"columns":columns},
            transformation_ctx=f"{table_name}_dynamic_frame"
        )
        df = dynamic_frame.toDF().toDF(*[col.lower() for col in dynamic_frame.toDF().columns])
        df.createOrReplaceTempView(table_name)
    except Exception as e:
        pass
    
def get_partition_date(args):
    year, month, day = args.get('year'), args.get('month'), args.get('day')
    if '0' in (year, month, day):
        partition_date = datetime.now() - timedelta(days=1)
    else:
        partition_date = datetime(year=int(year), month=int(month), day=int(day))
    return (partition_date.strftime('%Y'), partition_date.strftime('%m').lstrip(0), partition_date.strftime('%d').lstrip(0))

def main():
    sc = SparkContext.getOrCreate()
    glueContext = GlueContext(sc)
    spark = glueContext.spark_session
    args = getResolvedOptions(sys.argv, ["JOB_NAME", "year", "month", "day"])

    try:
        TABLE_CONFIG = {
            "xxx": {
                "table_name":"xxx",
                "database":"xxx",
                "columns": ["xxx","xxx"]
            }
        }

        partition_date = get_partition_date(args)
        for table_key, table_config int TABLE_CONFIG.items():
            load_and_register_table(glueContext, table_config, partition_date)
        resultado_query = spark.sql("SELECT * FROM xxx")
        resultado_query = resultado_query.dropDuplicates()
        resultado_query.show()

    except Exception as e:
        pass