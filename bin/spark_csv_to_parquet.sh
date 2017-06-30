#!/bin/sh
#1. sbt clean package
#2 submit application

/home/hewenting/spark/bin/spark-submit \
	--class "SimpleApp" \
	--master "spark://dell127:7077" \
	--executor-memory "40G" \
	--driver-memory "4G" \
	/home/hewenting/SparkCsvToParquet/target/scala-2.11/simple-project_2.11-1.0.jar \
    "$@"
