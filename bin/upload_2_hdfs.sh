#! /bin/sh

if [ $# != 3 ]
then
	echo "<Usage> sh upload_2_hdfs.sh \$TpchTableDir \$HdfsUrl \$HdfsDir"
	exit
fi

tables=(nation region part supplier partsupp lineitem orders customer)
for table in ${tables[@]}
do
	echo "hadoop fs -mkdir $3/$table"
	hadoop fs -mkdir $3/$table
	echo "hadoop fs -put $1/$table.tbl $2/$3/$table"
	hadoop fs -put $1/$table.tbl $2/$3/$table
done
