for i in $(seq 1 22)
do
	/home/hewenting/install/bin/impala-shell -i dell126:21000 -d impala_parquet_50g  -f /home/hewenting/workspace/tpch-impala/tpch-q$i.sql
done
