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
use List::MoreUtils 'any';
use feature 'say';

# Part One
# 5704

# my $filename = 'day-2-input.txt';
# open(my $ifh, '<', $filename);
# my @box_ids = <$ifh>;
# close $ifh;
# chomp(@box_ids);
# my %box_ids_freq;
# foreach my $id (@box_ids)
# {
    # foreach my $c (split //, $id)
    # {
        # $box_ids_freq{$id}{$c}++;
    # }
# }
# my %checksum;
# $checksum{'twice'} = 0;
# $checksum{'thrice'} = 0;
# foreach my $key (keys %box_ids_freq)
# {
    # my %freqs = %{$box_ids_freq{$key}};
    # $checksum{'twice'}++ if any {$_ == 2} values %freqs;
    # $checksum{'thrice'}++ if any {$_ == 3} values %freqs;
# }
# say $checksum{'twice'} * $checksum{'thrice'};

# Part Two
# umdryabviapkozistwcnihjqx

my $filename = 'day-2-input.txt';
open(my $ifh, '<', $filename);
my @box_ids = <$ifh>;
close $ifh;
chomp(@box_ids);
for my $i (@box_ids)
{
    for my $j (@box_ids)
    {
        my @f = split //, $i;
        my @s = split //, $j;
        my $zip_id = '';
        for (my $index = 0; $index < scalar @f; $index++)
        {
            $zip_id .= $f[$index] if $f[$index] eq $s[$index];
        }
        say $zip_id if length $zip_id == 25;
    }
}
