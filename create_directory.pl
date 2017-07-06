#!/usr/bin/env perl -w
#
# create_directory.pl is a script to create a directory.xml from a CSV
#
# Copyright (c) 2017 Max Clark
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, version 3.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.
#

# Load necessary perl module(s)
# --
use warnings;
use strict;
use Getopt::Long;
use Text::CSV;
# use Math::Round;
use Polycom::Contact::Directory;

# Usage and Help
# --
sub usage {
    print "\n";
    print "usage: [*options*]\n";
    print "  -h, --help           display this help and exit\n";
    print "  -v, --verbose        display debug messages\n";
    print "  -f, --file           path to csv file *required\n";
    print "\n";
    exit;
}

# Default values
#--
my %opt = ();

GetOptions(\%opt,
        'debug', 'help|h', 'verbose|v', 'file|f=s'
        ) or exit(1);
usage if $opt{help};

unless (defined $opt{file}) {
    print "\nError: You must define a file!\n";
    usage;
}

# Warn if required options are not present
# --
# $DEBUG = "1" if defined $opt{debug};

# Create the csv reference
# --
my $csv = Text::CSV->new();
my $dir = Polycom::Contact::Directory->new();

# Open the csv
# --
open FILE, "<$opt{file}" || "Cannot open file: $!";

# Skip the header row
# --
# <FILE>;

# Read the file in and process it
# --
while (<FILE>) {
  next if /^\#/;
  if ($csv->parse($_)) {
    my @fields = $csv->fields;

    my $fname = $fields[0];
    my $lname = $fields[1];
    my $ext = $fields[2];

    # Add a contact
    $dir->insert(
      {   first_name => $fname,
          last_name  => $lname,
          contact    => $ext,
      },
    );
  };
};

close FILE;

$dir->save('directory.xml');
