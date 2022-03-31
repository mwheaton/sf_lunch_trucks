#!/usr/bin/perl

$csv_file = "Mobile_Food_Facility_Permit.csv";

open(CSV, "<$csv_file") or die "cannot open game file $csv_file\n";

foreach $csvline (<CSV>)
  {
    print $csvline;
  }
