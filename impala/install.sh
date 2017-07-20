#!/usr/bin/env bash

if [ $# -ne 2 ]
then
	echo "<Usage> sh install.sh -impala_home=\$IMPALA_HOME -build_type=debug|release"
	exit
fi
for ARG in $*
do
    case "$ARG" in
        -impala_home=*)
            IFS='=' read -ra arg <<< "$ARG"
            IMPALA_HOME="${arg[1]}"
            ;;
        -build_type=debug)
            BUILD_TYPE=debug
            ;;
        -build_type=release)
            BUILD_TYPE=release
            ;;
        -build_type=*)
            echo "Invalid build type. Valid values are: debug, install"
            exit 1
            ;;
    esac
done
: "${IMPALA_HOME? missing -impala_home=IMPALA_HOME}"

: "${BUILD_TYPE? missing -build_type=\{debug | install\}}"

SCRIPT=$(cd $(dirname ${BASH_SOURCE:-$0})  && pwd)
INSTALL_DIR=$SCRIPT/install
echo "install dir: $INSTALL_DIR"
pushd $IMPALA_HOME
#if [ $BUILD_TYPE = "release" ]; then
#    ./buildall.sh -notests -noclean -release
#else
#    ./buildall.sh -notests -noclean
#fi


rm -rf  $INSTALL_DIR
mkdir -p $INSTALL_DIR/lib
mkdir -p $INSTALL_DIR/bin
mkdir -p $INSTALL_DIR/logs
mkdir -p $INSTALL_DIR/jars
mkdir -p $INSTALL_DIR/conf
mkdir -p $INSTALL_DIR/shell/lib
mkdir -p $INSTALL_DIR/shell/ext-py

cp $SCRIPT/startup.sh $INSTALL_DIR/
cp $SCRIPT/impala-shell $INSTALL_DIR/bin/
cp $SCRIPT/kill.py $INSTALL_DIR/bin/

THRIFT_HOME=$IMPALA_HOME/toolchain/thrift-0.9.0-p9/
if [ -d ${THRIFT_HOME}/python/lib/python*/site-packages/thrift ]; then
  cp -r ${THRIFT_HOME}/python/lib/python*/site-packages/thrift\
        $INSTALL_DIR/shell/lib
else
  cp -r ${THRIFT_HOME}/python/lib64/python*/site-packages/thrift\
        $INSTALL_DIR/shell/lib
fi
find $(pwd)/fe/target/dependency/ -name *.jar -exec ln -sf {} $INSTALL_DIR/jars \;
cp -fL $(pwd)/fe/target/impala-frontend-0.1-SNAPSHOT.jar $INSTALL_DIR/jars/

find $(pwd)/be/build/${BUILD_TYPE} -name impalad -exec cp -fL {} $INSTALL_DIR/bin/ \;
find $(pwd)/be/build/${BUILD_TYPE} -name catalogd -exec cp -fL {} $INSTALL_DIR/bin/ \;
find $(pwd)/be/build/${BUILD_TYPE} -name statestored -exec cp -fL {} $INSTALL_DIR/bin/ \;

cp -fL $(pwd)/toolchain/thrift-0.9.0-p9/lib/libthrift-0.9.0.so $INSTALL_DIR/lib/
cp -fL $(pwd)/toolchain/boost-1.57.0-p*/lib/libboost_system.so.1.57.0 $INSTALL_DIR/lib/
cp -fL $(pwd)/toolchain/gcc-4.9.2/lib64/libstdc++.so.6 $INSTALL_DIR/lib/
cp -fL $(pwd)/toolchain/kudu-*/$BUILD_TYPE/lib64/libkudu_client.so.0 $INSTALL_DIR/lib/


find $(pwd)/shell/ext-py/ '(' -name *egg ')' -exec ln -sf {} $INSTALL_DIR/shell/ext-py/ \;
ln -sf $(pwd)/shell/impala_shell.py $INSTALL_DIR/shell/
ln -sf $(pwd)/shell/impala_client.py $INSTALL_DIR/shell/lib/
ln -sf $(pwd)/shell/option_parser.py $INSTALL_DIR/shell/lib/
ln -sf $(pwd)/shell/shell_output.py $INSTALL_DIR/shell/lib/
ln -sf $(pwd)/shell/thrift_sasl.py $INSTALL_DIR/shell/lib/
ln -sf $(pwd)/shell/pkg_resources.py $INSTALL_DIR/shell/lib/
ln -sf $(pwd)/shell/impala_shell_config_defaults.py $INSTALL_DIR/shell/lib/
ln -sf $(pwd)/shell/gen-py $INSTALL_DIR/shell/
ln -sf $(pwd)/www $INSTALL_DIR/
popd
