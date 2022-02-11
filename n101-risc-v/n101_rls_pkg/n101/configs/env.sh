
cur_dir=`pwd`
up_dir=`dirname $cur_dir`
export PROJ_SRC_ROOT=`dirname $up_dir`
export PROJ_NAME=n101
export PROJ_GEN_ROOT=$PROJ_SRC_ROOT/${PROJ_NAME}_cct

cat /proc/version | grep -i ubuntu
if [ $? == 0 ];
then
    echo "ubuntu system"
    return
fi

strings /lib64/libc.so.6 | grep ^GLIBC_2.14 > /dev/null
if [ $? != 0 ];
then
    export LD_LIBRARY_PATH=$cur_dir:$LD_LIBRARY_PATH
fi

