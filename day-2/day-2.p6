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
# 5704

# my $filename = 'day-2-input.txt';
# my @box_ids = $filename.IO.lines(:chomp);
# my %box_ids_freq;
# for @box_ids -> $id
# {
    # my %char_count;
    # for $id.split('') -> $c
    # {
        # %char_count{$c}++ if $c ~~ 'a'..'z'.any;
    # }
    # %box_ids_freq{$id} = %char_count;
# }
# my %checksum = 'twice' => 0;
# %checksum = 'thrice' => 0;
# for values %box_ids_freq -> %f
# {
    # %checksum{'twice'}++ if 2 == (values %f).any;
    # %checksum{'thrice'}++ if 3 == (values %f).any;
# }
# say %checksum{'twice'} * %checksum{'thrice'};

# Part Two
# umdryabviapkozistwcnihjqx

my $filename = 'day-2-input.txt';
my @box_ids = $filename.IO.lines(:chomp);
for combinations @box_ids, 2 -> @combs
{
    my @zipped_ids = zip(@combs[0].split('',:skip-empty), @combs[1].split('',:skip-empty));
    my $zip_id = '';
    for @zipped_ids -> @y
    {
        $zip_id ~= @y[0] if @y[0] ~~ @y[1];
    }
    say $zip_id if $zip_id.chars == 25;
}
