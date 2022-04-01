#!/usr/bin/perl

use Getopt::Std;
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

sub load_headers()
  {
    # print  "loading headers\n";
    @csvline_array = (<CSV>);

    # process the first line to get the field names
    chomp $csvline_array[0];                      # get rid of newline
    my @initial_field_list = split(',', $csvline_array[0]);
    shift @csvline_array;                         # take the headers off the list of lines

    # remove leading, trailing whitespace, replace remaining spaces
    # with underscores @field_list is the array I use elsewhere, so it
    # should contain the polished list.Start with an array local to
    # this method

    foreach $field (@initial_field_list)
      {
	$field =~ s/(\s*)(\.*)$/\2/;  # leading spaces
	$field =~ s/^(\.*)(\s*)/\1/;  # trailing spaces
	$field =~ s/\s+/_/;  # internal spaces

	push(@field_list, $field);
      }
    # print Dumper(\@field_list);

  }

sub print_headers()
  {
    print "Fields you may select are:\n";
    foreach $field (@field_list)
      {
	print "\t$field\n";
      }
    print "use \" -l <field_list>\" to retrieve those fields\n";
  }

sub load_csv()
  {

    # use the headers to map each field to a hash element for each line creating an array of hashes
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
	    # print "$i: $field_list[$i] ---> $elem_array[$i]\n";
	    $vendor_info->{$field_list[$i]} = $elem_array[$i];
	  }
	push(@truck_data, $vendor_info);

      } # foreach $csvline
  } # sub load_csv
##############################
# main script
##############################

# need to add an option to list the field names and exit, it makes
# sense to break load_csv() into two methods one to load the header
# information, and another to load the data.  Right now it doesn't
# matter much, but if the data was to get really large, it would be
# very important to not load the data when all we want is a header
# list


# get command line flag arguments
# TODO: turn this list into help() output
# -l <list>  -- list the data for the fields provided in <list>
# -s         -- show the list of possible fields
  getopts("sl:");


  load_headers();

  if($opt_s)
    {
      print_headers();
      exit;
    }

  load_csv();

