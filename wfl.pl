#!/usr/bin/perl


# the csv file might make more sense as a command line argument, especially if it changes, or different sources are used
# it might also be replaced by data on the web retrieved with a get (do we still use cgi-bin?)

$csv_file = "Mobile_Food_Facility_Permit.csv";
open(CSV, "<$csv_file") or die "cannot open game file $csv_file\n";

# functional decomposition for a small script can be overkill, but we should make the effort with the idea that
# we want the code to be modular enough to make changes easily, provide something easier to come back to, or for others to work on


sub load_csv()
  {

    @csvline_array = (<CSV>);
    foreach $csvline (@csvline_array)
      {
	print $csvline;
      }
  }
##############################
# main script
##############################


load_csv();
