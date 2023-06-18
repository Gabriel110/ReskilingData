import sys
from awsglue.transforms import *
from awsglue.utils import getResolvedOptions
from pyspark.context import SparkContext
from awsglue.context import GlueContext
from awsglue.job import Job
from awsglue.dynamicframe import DynamicFrame

args = getResolvedOptions(sys.argv, ["JOB_NAME"])
sc = SparkContext()
glueContext = GlueContext(sc)
spark = glueContext.spark_session
job = Job(glueContext)
job.init(args["JOB_NAME"], args)

# Script generated for node Amazon S3
AmazonS3_node1686181087494 = glueContext.create_dynamic_frame.from_catalog(
    database="glue-database-animes",
    table_name="anime",
    transformation_ctx="AmazonS3_node1686181087494",
)

# Script generated for node Amazon S3
AmazonS3_node1686181115026 = glueContext.create_dynamic_frame.from_catalog(
    database="glue-database-animes",
    table_name="rating",
    transformation_ctx="AmazonS3_node1686181115026",
)

# Script generated for node Join
AmazonS3_node1686181087494DF = AmazonS3_node1686181087494.toDF()
AmazonS3_node1686181115026DF = AmazonS3_node1686181115026.toDF()
Join_node1686181110266 = DynamicFrame.fromDF(
    AmazonS3_node1686181087494DF.join(
        AmazonS3_node1686181115026DF,
        (
            AmazonS3_node1686181087494DF["anime_id"]
            == AmazonS3_node1686181115026DF["anime_id"]
        ),
        "right",
    ),
    glueContext,
    "Join_node1686181110266",
)

# Script generated for node Drop Fields
DropFields_node1686181160620 = DropFields.apply(
    frame=Join_node1686181110266,
    paths=["anime_id"],
    transformation_ctx="DropFields_node1686181160620",
)

# Script generated for node Amazon S3
AmazonS3_node1686181168658 = glueContext.getSink(
    path="s3://anime-bucket-122334/processed/full/",
    connection_type="s3",
    updateBehavior="UPDATE_IN_DATABASE",
    partitionKeys=[],
    compression="snappy",
    enableUpdateCatalog=True,
    transformation_ctx="AmazonS3_node1686181168658",
)
AmazonS3_node1686181168658.setCatalogInfo(
    catalogDatabase="glue-database-animes", catalogTableName="full"
)
AmazonS3_node1686181168658.setFormat("glueparquet")
AmazonS3_node1686181168658.writeFrame(DropFields_node1686181160620)
job.commit()
