#!/usr/bin/perl

#******************************************************************
#
# sv_tb.pl module
#
#******************************************************************
#
#	Cornell University @ 2011
#
#******************************************************************
#
# created on:	04/29/2011
# created by:	hwang
# last edit on:	$DateTime: $ 
# last edit by:	$Author: $
# revision:	$Revision: $
# comments:	Generated
# 
#******************************************************************
# Revision List:
#
#		1.0	05/02/2009	Initial release
# 
#******************************************************************
# SystemVerilog Tools Module
#
#  This utility is intended to make designing with SystemVerilog
#  simpler. This utility supports the following options:
#
#      Usage: svtools.pl [-h] [-v] [-t] [-f <FILE>]
#      
#              -h              Print this help message.
#              -v              Verbose: Print Debug Information.
#              -t              Generate SystemVerilog Test Bench.
#              -f <FILE>       SystemVerilog input file.
#      
#  Example of Module Instantiation:
#  
#	svtools.pl -t -f sample.v
#  
#  Save this file in your home 'bin' directory.
#
#******************************************************************

#******************************************************************
# CPAN Modules
#******************************************************************
use strict;
use warnings;
use Getopt::Std;

#******************************************************************
# Custom Modules
#******************************************************************
use SystemVerilogTools qw( genTBTestFile );

#******************************************************************
# Constants and Variables:
#******************************************************************
my (%svH, $sv_rH);
my (%opts)=();
my ($file);
my ($debug);

#******************************************************************
# Retrieve command line argument
#******************************************************************
getopts('hvtf:',\%opts);

my $optslen = scalar( keys %opts );
print("Number of Options on Command-Line: $optslen\n") if $opts{v};
# check for valid combination of command-line arguments
if ( $opts{h} || !$opts{f} || !($opts{t}) || ($optslen eq "0") ) {
    print_usage();
    exit;
}

# parse command-line arguments
$file  = $opts{f};
$debug = $opts{v};

#******************************************************************
# Make Date int MM/DD/YYYY
#******************************************************************
my $year      = 0;
my $month     = 0;
my $day       = 0;
($day, $month, $year) = (localtime)[3,4,5];

#******************************************************************
# Grab username from PC:
#******************************************************************
my $author= "$^O user";
if ($^O =~ /mswin/i) { 
    $author= $ENV{USERNAME} if defined $ENV{USERNAME};
} else { 
    $author = getlogin();
}

#******************************************************************
# Initialize Verilog Hash:
#******************************************************************
$svH{ 'username' } = $author;
$svH{ 'file' } = $file;
$svH{ 'day' } = $day;
$svH{ 'month' } = $month;
$svH{ 'year' } = $year;
$svH{ 'debug' } = $debug;

#******************************************************************
# Generate Test Bench File:
#******************************************************************
if ($opts{t}) {
    $sv_rH = genTBTestFile(\%svH);
}


exit;
 
#******************************************************************
# Generic Error and Exit routine 
#******************************************************************
 
sub dienice {
    my($errmsg) = @_;
    print"$errmsg\n";
    exit;
}

sub print_usage {
    my ($usage);
    $usage = "\nUsage: $0 [-h] [-v] [-t] [-f <FILE>]\n";
    $usage .= "\n";
    $usage .= "\t-h\t\tPrint this help message.\n";
    $usage .= "\t-v\t\tVerbose: Print Debug Information.\n";
    $usage .= "\t-t\t\tGenerate SystemVerilog Test Bench.\n";
    $usage .= "\t-f <FILE>\tSystemVerilog input file.\n";
    $usage .= "\n";
    $usage .= "\tExample of Module Instantiation:\n";
    $usage .= "\t\t$0 -t -f sample.v \n";
    $usage .= "\n";
    print($usage);
    return;
}

