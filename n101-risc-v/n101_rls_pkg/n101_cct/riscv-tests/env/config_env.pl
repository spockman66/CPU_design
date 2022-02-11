#!/usr/bin/env perl
use strict;
use warnings;
my %hash_config;

#my $config_file = '/home/zaixin/work/n100_cct/rtl/n205/core/config.v';
#my $testdir_file = '/home/zaixin/work/n100_cct/vsim/run/env_flist';

my $config_file = $ARGV[0];
my $testdir_file = $ARGV[1];


open (CONFIGV , $config_file) or die ("unable to open congigfile:$!\n");

while (my $line=<CONFIGV>){
  if ($line =~ /^\s*`define\s+(\w+)\s+$/){
    $hash_config{"$1"} = "1";
  }
  elsif ($line =~ /^\s*`define\s+(\w+)\s+([0-9]+)\s+$/){
    $hash_config{"$1"} = "$2";
  }
  elsif ($line =~ /^\s*`define\s+(\w+)\s+(`?.*'h)(\w+)\s+$/){
    $hash_config{"$1"} = "$3";
  }

}

my $var1;
my $var2;
my $print_or_not_print;
my $cnt;
my $test_file;
my $new_test_file;
my $dir;
my @real_value;

open (FILELIST , $testdir_file) or die ("unable to open testfile:$!\n");

while (my $line=<FILELIST>){
  if($line =~ /(.*)\/env_orig(.*)\/(.*)$/){
    $test_file = $line;
    $dir =  $1."\/env$2\/";
    `mkdir -p $dir`;
    $new_test_file = $1."\/env$2\/".$3;
  }
  open (TESTFILE , "<$test_file") or die ("unable to open testfile:$!\n");
  open (NEWTESTFILE , "+>$new_test_file") or die ("unable to open testfile:$!\n");
  $print_or_not_print = 1;
  $cnt = 0;
  while(<TESTFILE>){
    if($cnt == 0) {$print_or_not_print = 1};
    if (($_ =~ /^\s*#`ifdef\s+(\w+)/) || ($_ =~ /^\s*\/\*#`ifdef\s+(\w+)/) || ($_ =~ /^\s*\/\*#`ifdef\s+(\w+)\*\//)){
      if(exists $hash_config{$1}){
          if($cnt == 0){
            $print_or_not_print = 1;
          }
          else{
            $print_or_not_print = 0;
          }
      }
      else{
        $cnt = $cnt + 1;
        $print_or_not_print = 0;
      }
    }

    if (($_ =~ /^\s*#`endif\s+(\w+)/) || ($_ =~ /^\s*\/\*#`endif\s+(\w+)/) || ($_ =~ /^\s*\/\*#`endif\s+(\w+)\*\//)){
      if($cnt == 0){
        $print_or_not_print = 1;
      }
      else{
        $print_or_not_print = 0;
      }
      if (exists $hash_config{$1}==0){
        $cnt = $cnt - 1;
      }
    }

    if (($_ =~ /^\s*#`ifndef\s+(\w+)/) || ($_ =~ /^\s*\/\*#`ifndef\s+(\w+)/) || ($_ =~ /^\s*\/\*#`ifndef\s+(\w+)\*\//)){
      if(exists $hash_config{$1} == 0){
          if($cnt == 0){
            $print_or_not_print = 1;
          }
          else{
            $print_or_not_print = 0;
          }
      }
      else{
        $cnt = $cnt + 1;
        $print_or_not_print = 0;
      }
    }

    if (($_ =~ /^\s*#`endnif\s+(\w+)/) || ($_ =~ /^\s*\/\*#`endnif\s+(\w+)/) || ($_ =~ /^\s*\/\*#`endnif\s+(\w+)\*\//)){
      if($cnt == 0){
        $print_or_not_print = 1;
      }
      else{
        $print_or_not_print = 0;
      }
      if (exists $hash_config{$1}){
        $cnt = $cnt - 1;
      }
    }



    if($_ =~ /(^.*)`(.*)`(.*$)/){
      if(exists $hash_config{$2}){
       @real_value = $hash_config{$2};
       $_ =~ s/`$2`/@real_value/;
      }
    }

    if($print_or_not_print == 1) {print NEWTESTFILE $_};

  }
  close (TESTFILE);
  close (NEWTESTFILE);

}
close (FILELIST);
