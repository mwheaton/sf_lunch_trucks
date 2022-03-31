#!/usr/bin/perl

use Data::Dumper;
$Data::Dumper::Purity = 1;
$Data::Dumper::Indent = 2;
# the csv file might make more sense as a command line argument, especially if it changes, or different sources are used
# it might also be replaced by data on the web retrieved with a get (do we still use cgi-bin?)

$csv_file = "Mobile_Food_Facility_Permit.csv";
$csv_file = "short.csv";
open(CSV, "<$csv_file") or die "cannot open game file $csv_file\n";

# functional decomposition for a small script can be overkill, but we should make the effort with the idea that
# we want the code to be modular enough to make changes easily, provide something easier to come back to, or for others to work on


sub load_csv()
  {

    @csvline_array = (<CSV>);

    # process the first line to get the field names
    chomp $csvline_array[0];                      # get rid of newline
    @field_list = split(',', $csvline_array[0]);
    shift @csvline_array;                         # take the headers off the list of lines

    # proving I have the right scalar to limit the array iteration
#     $size =scalar(@field_list);
#     print "array size: $size \n";
#     for(my $i =0; $i < @field_list; $i++)
#       {
# 	print "F: $field_list[$i]\n";
#       }
#     exit;

    # now we can actually use the headers to map each field to a hash element for each line creating an array of hashes
    # this could also be an array of objects
    # this may be the first time ever I used array indexing to iterate over the data, because I want to map header[n] to field[n]

    # process the rest of the csv
    foreach $csvline (@csvline_array)
      {
	chomp $csvline;                      # get rid of newline
	@elem_array = split(',', $csvline);
	my $vendor_info = {};                   # make sure to clear the hash in case fields aren't reset 
	for(my $i = 0; $i < @field_list; $i++)
	  {
	    print "$i: $field_list[$i] ---> $elem_array[$i]\n";
	    $vendor_info->{$field_list[$i]} = $elem_array[$i];
	  }
	# print Dumper(\$vendor_info);
	push(@truck_data, $vendor_info);

      } # foreach $csvline
    print Dumper(\@truck_data);

    # print Dumper(\@truck_data[3]);

#     foreach $csvline (@csvline_array)
#       {
# 	@elem_array = split(',', $csvline);
# 	print $csvline;
# 	foreach $elem (@elem_array)
# 	  {
# 	    print "E $elem\n";
# 	  }
#       } # foreach $csvline
  }
##############################
# main script
##############################


load_csv();

