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
use List::MoreUtils 'all';
use feature 'say';

# Function definitions

sub part_one
{
    my $polymers = shift;
    my @letter_pairs;
    for my $ltr ('a'..'z')
    {
        push @letter_pairs, $ltr . (uc $ltr);
        push @letter_pairs, (uc $ltr) . $ltr;
    }
    my $found = 'true';
    while ($found eq 'true')
    {
        for my $pair (@letter_pairs)
        {
            $polymers =~ s/$pair//g;
        }
        if (all {index($polymers, $_) == -1} @letter_pairs)
        {
            $found = 'false';
        }
    }
    say length $polymers;
}

sub part_two
{
    my $polymers = shift;
    my @letter_pairs;
    my %letter_strprs;
    for my $ltr ('a'..'z')
    {
        push @letter_pairs, $ltr . (uc $ltr);
        push @letter_pairs, (uc $ltr) . $ltr;
        my $ucltr = uc $ltr;
        $letter_strprs{$ltr} = $polymers =~ s/$ltr|$ucltr//gr;
    }
    my $shortest_chain = 50000;
    while (my ($key, $value) = each %letter_strprs)
    {
        my $found = 'true';
        while ($found eq 'true')
        {
            for my $pair (@letter_pairs)
            {
                $value =~ s/$pair//g;
            }
            if (all {index($value, $_) == -1} @letter_pairs)
            {
                $found = 'false';
            }
        }
        $shortest_chain = length $value if $shortest_chain > length $value;
    }
    say $shortest_chain;
}

my $filename = 'day-5-input.txt';
open(my $ifh, '<', $filename);
my $input_file = <$ifh>;
close $ifh;
chomp($input_file);
# part_one($input_file); # 11364
part_two($input_file); # 4212
