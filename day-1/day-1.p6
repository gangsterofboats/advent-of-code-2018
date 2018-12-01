#!/usr/bin/env perl6
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

# Part One

my $initial_value = 0;
my $filename = 'day-1-input.txt';
my @input_file = $filename.IO.lines(:chomp);
say @input_file.sum;

# Part Two
## Well, Part One works.  Cannot seem to be able to test Part Two

# my $current_sum = 0;
# my @prev_sums;
# my $filename = 'day-1-input.txt';
# my @input_file = $filename.IO.lines(:chomp);
# my @numbers = @input_file.map: {.Int};
# my $i = 0;
# loop
# {
    # $current_sum += @numbers[$i++ % @numbers];
    # if not ($current_sum eq any(@prev_sums))
    # {
        # @prev_sums.push($current_sum);
    # }
    # else
    # {
        # say $current_sum;
        # last;
    # }
# }
