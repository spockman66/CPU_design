
set cur_dir =  `pwd`
set up_dir =  `dirname $cur_dir`
setenv PROJ_SRC_ROOT `dirname $up_dir`
setenv PROJ_NAME n101
setenv PROJ_GEN_ROOT $PROJ_SRC_ROOT/${PROJ_NAME}_cct

cat /proc/version | grep -i ubuntu > /dev/null
if( $status == 0) then
    echo "ubuntu system"
    return 
endif

strings /lib64/libc.so.6 | grep ^GLIBC_2.14 > /dev/null
if( $status != 0) then
    setenv LD_LIBRARY_PATH ${cur_dir}:$LD_LIBRARY_PATH
endif

