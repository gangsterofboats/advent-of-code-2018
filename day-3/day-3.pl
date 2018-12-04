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
use feature 'say';

# Part One
# 121163

# my $filename = 'day-3-input.txt';
# open(my $ifh, '<', $filename);
# my @claims = <$ifh>;
# close $ifh;
# chomp(@claims);
# my @fabric_map;
# push @fabric_map, [(0) x 1000] for (0..1000);
# for my $c (@claims)
# {
    # my ($id, $at_sign, $xy, $wt) = split(/ /, $c);
    # $id = substr($id, 1);
    # my ($x_offset, $y_offset) = split(/,/, $xy);
    # my ($wide, $tall) = split(/x/, $wt);
    # $y_offset = substr($y_offset, 0, -1);
    # for my $hindex ($y_offset..$y_offset + $tall - 1)
    # {
        # for my $windex ($x_offset..$x_offset + $wide - 1)
        # {
            # $fabric_map[$hindex][$windex]++;
        # }
    # }
# }
# my $count;
# for (map {@$_} @fabric_map)
# {
    # $count++ if $_ >= 2;
# }
# say $count;


# Part Two
# 943

my $filename = 'day-3-input.txt';
open(my $ifh, '<', $filename);
my @input_file = <$ifh>;
close $ifh;
chomp(@input_file);
my @fabric_map;
my @ids;
my %claims;
push @fabric_map, [(0) x 1000] for (0..1000);
for my $c (@input_file)
{
    my ($id, $at_sign, $xy, $wt) = split(/ /, $c);
    $id = substr($id, 1);
    push @ids, $id;
    my ($x_offset, $y_offset) = split(/,/, $xy);
    my ($width, $height) = split(/x/, $wt);
    $y_offset = substr($y_offset, 0, -1);
    $claims{$id} = [$x_offset, $y_offset, $width, $height];
    for my $hindex ($y_offset..$y_offset + $height - 1)
    {
        for my $windex ($x_offset..$x_offset + $width - 1)
        {
            $fabric_map[$hindex][$windex]++;
        }
    }
}
while (my ($key, $value) = each %claims)
{
    my ($x_origin, $y_origin, $wide, $tall) = @{$value};
    for my $hindex ($y_origin..$y_origin + $tall - 1)
    {
        for my $windex ($x_origin..$x_origin + $wide - 1)
        {
            if ($fabric_map[$hindex][$windex] > 1)
            {
                @ids = grep {$_ != $key} @ids;
            }
        }
    }
}
say @ids;
