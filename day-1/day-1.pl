#!/usr/bin/env perl
################################################################################
# Copyright (C) 2018 Michael Wiseman                                           #
#                                                                              #
# This program is free software: you can redistribute it and/or modify it      #
# under the terms of the GNU Affero General Public License as published by the #
# Free Software Foundation, either version 3 of the License, or (at your       #
# option) any later version.                                                   #
#                                                                              #
# This program is distributed in the hope that it will be useful, but WITHOUT  #
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or        #
# FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Affero General Public License #
# for more details.                                                            #
#                                                                              #
# You should have received a copy of the GNU Affero General Public License     #
# along with this program.  If not, see <https://www.gnu.org/licenses/>.       #
################################################################################
use strict;
use warnings;
use List::Util qw(any sum);
use feature 'say';

# Part One

# my $initial_value = 0;
# my $filename = 'day-1-input.txt';
# open(my $ifh, '<', $filename);
# my @input_file = <$ifh>;
# close $ifh;
# chomp(@input_file);
# say sum @input_file;

# Part Two

my $current_sum = 0;
my @prev_sums;
my $filename = 'day-1-input.txt';
open(my $ifh, '<', $filename);
my @input_file = <$ifh>;
close $ifh;
my @numbers = map(int, @input_file);
my $i = 0;

while (1)
{
    $current_sum += int($numbers[$i++ % @numbers]);
    if (!(any {$_ == $current_sum} @prev_sums))
    {
        push @prev_sums, $current_sum;
    }
    else
    {
        say $current_sum;
        last;
    }
}
