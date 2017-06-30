for i in $(seq 10)
do 
	./dbgen -S $i -s 30 -C 10 -v
done 
SERVICES="part partuspp customer supplier orders lineitem nation nation" 
for word in $SERVICES 
do 
	mkdir data/$word mv $word.tbl* data/$word 
	hadoop fs -put data/$word /data 
done
