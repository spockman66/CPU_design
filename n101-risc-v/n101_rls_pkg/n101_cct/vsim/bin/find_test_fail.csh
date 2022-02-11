#!/bin/bash
ok=`grep "Test Finish" $1 | wc -l`
if [ $ok -ne "1" ];
then 
    echo -e "NOT_FINISHED $1"
else
    #test_fails=`grep 'TEST_FAIL : *[0-9]*' $1  | sed 's/.*TEST_FAIL : *\([0-9]*\).*/\1/g'`
    test_passes=`grep "TEST_PASS" $1 | wc -l`
    res=`expr $test_passes + 0`
    if [ $res -ne 0 ];
    	then echo -e "PASS $1";
        else echo -e "FAIL $1";
    fi
fi
