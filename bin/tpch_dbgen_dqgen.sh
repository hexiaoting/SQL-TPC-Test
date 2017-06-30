#生成数据用dbgen命令
# -C 表示把文件切分为100个块
#-S 输出第2个块（15001-30000行的数据）
# -s 扩大的因素
# -T c只输出customer这个表
#会在当前目录下生成customer.tbl相关的文件
cd dbgen
./dbgen -S 2 -s 10 -T c -C 100 -v

#生成22个查询请求
export DSS_QUERY=`pwd`/queries
./qgen | sed -e 's/\r//' >queries/tpch_queries.sql
