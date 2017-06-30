#!/usr/bin/env bash

if [ $# == 0 ]
then
    echo "<Usage> sh startup.sh \$STATESTORE_HOST/\$CATALOG_HOME \$Start_catalog/statestore_ornot"
    exit
fi

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
done
LIB_JAVA=`find ${JAVA_HOME}/   -name libjava.so | head -1`
LIB_JSIG=`find ${JAVA_HOME}/   -name libjsig.so | head -1`
LIB_JVM=` find ${JAVA_HOME}/   -name libjvm.so  | head -1`
LIB_HDFS=`find ${HADOOP_HOME}/ -name libhdfs.so | head -1`
LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:`dirname ${LIB_JAVA}`:`dirname ${LIB_JSIG}`"
LD_LIBRARY_PATH="${LD_LIBRARY_PATH}:`dirname ${LIB_JVM}`:`dirname ${LIB_HDFS}`"
export IMPALA_HOME="$( cd -P "$( dirname "$SOURCE" )/.." && pwd )/install/"
export LD_LIBRARY_PATH=${IMPALA_HOME}/lib:$LD_LIBRARY_PATH

CONF_DIR=${IMPALA_HOME}/conf
LOG_DIR=${IMPALA_HOME}/logs
CLASSPATH="${CLASSPATH}:$CONF_DIR"
for jar in "${IMPALA_HOME}"/jars/*.jar; do
  if [ -e "$jar" ] ; then
    CLASSPATH="${CLASSPATH}:$jar"
  fi
done
export CLASSPATH


if [ $# -gt 1 ]
then
    echo "start catalog and statestored"
    nohup ${IMPALA_HOME}/bin/statestored -log_filename=statestored -log_dir=$LOG_DIR -disable_kudu=true -v=1 -logbufsecs=5 -max_log_files=10 > /dev/null & disown
    nohup ${IMPALA_HOME}/bin/catalogd -log_filename=catalogd -disable_kudu=true  -log_dir=$LOG_DIR  -v=1 -state_store_port=24000 -catalog_service_port=26000 -logbufsecs=5 -max_log_files=10  > /dev/null & disown
fi

echo "start impalad"
echo "${IMPALA_HOME}/bin/impalad -beeswax_port=21000 -hs2_port=21050 -be_port=22000 -webserver_port=25000 -state_store_subscriber_port=23000 -log_filename=impalad -disable_kudu=true -load_catalog_in_background=true -log_dir=$LOG_DIR -v=1 -logbufsecs=5 -max_log_files=10 -state_store_port=24000 -catalog_service_port=26000 -catalog_service_host=$1 -state_store_host=$1"
${IMPALA_HOME}/bin/impalad -beeswax_port=21000 -hs2_port=21050 -be_port=22000 -webserver_port=25000 -state_store_subscriber_port=23000 -log_filename=impalad -disable_kudu=true -load_catalog_in_background=true -log_dir=$LOG_DIR -v=1 -logbufsecs=5 -max_log_files=10 -state_store_port=24000 -catalog_service_port=26000 -catalog_service_host=$1 -state_store_host=$1
