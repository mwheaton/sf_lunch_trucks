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

    # process the first line to get the field names
    @field_list = split(',', $csvline_array[0]);
    shift @csvline_array;                         # take the headers off the list of lines

    foreach $field (@field_list)
      {
	print "F: $field\n";
      }
    exit;

    foreach $csvline (@csvline_array)
      {
	@elem_array = split(',', $csvline);
	print $csvline;
	foreach $elem (@elem_array)
	  {
	    print "E $elem\n";
	  }
      }
  }
##############################
# main script
##############################


load_csv();
