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

sub part-one(@input)
{
    my @fabric-map;
    for (0..^1000) -> $i
    {
        for (0..^1000) -> $j
        {
            @fabric-map[$i][$j] = 0;
        }
    }
    for @input -> $claim
    {
        my ($id, $at-sign, $xy, $wt) = $claim.split(' ');
        $id = substr($id, 1..-1).Int;
        my ($x-offset, $y-offset) = $xy.split(/\,/);
        $x-offset = $x-offset.Int;
        my ($wide, $tall) = $wt.split(/x/);
        ($wide, $tall) = ($wide.Int, $tall.Int);
        $y-offset = substr($y-offset, 0, *-1).Int;
        for ($y-offset..$y-offset + $tall - 1) -> $hindex
        {
            for ($x-offset..$x-offset + $wide - 1) -> $windex
            {
                @fabric-map[$hindex][$windex]++;
            }
        }
    }
    my $count = 0;
    for (@fabric-map.flatmap({.list})) -> $sq
    {
        $count++ if $sq >= 2;
    }
    say $count;
}

sub part-two(@input)
{
    my @fabric-map;
    for (0..^1000) -> $i
    {
        for (0..^1000) -> $j
        {
            @fabric-map[$i][$j] = 0;
        }
    }
    my @ids;
    my %claims;
    for @input -> $claim
    {
        my ($id, $at-sign, $xy, $wt) = $claim.split(' ');
        $id = substr($id, 1..-1).Int;
        my ($x-offset, $y-offset) = $xy.split(/\,/);
        $x-offset = $x-offset.Int;
        my ($wide, $tall) = $wt.split(/x/);
        ($wide, $tall) = ($wide.Int, $tall.Int);
        $y-offset = substr($y-offset, 0, *-1).Int;
        @ids.append: $id;
        %claims{$id} = [$x-offset, $y-offset, $wide, $tall];
        for ($y-offset..$y-offset + $tall - 1) -> $hindex
        {
            for ($x-offset..$x-offset + $wide - 1) -> $windex
            {
                @fabric-map[$hindex][$windex]++;
            }
        }
    }
    for %claims.kv -> $key, @value
    {
        my ($x-origin, $y-origin, $width, $height) = @value;
        for ($y-origin..$y-origin + $height - 1) -> $hx
        {
            for ($x-origin..$x-origin + $width - 1) -> $wx
            {
                if (@fabric-map[$hx][$wx] > 1)
                {
                    @ids .= grep: * ne $key;
                }
            }
        }
    }
    say @ids;
}

# Part One => 121163
# Part Two => 943

my $filename = 'day-3-input.txt';
my @input-file = $filename.IO.lines(:chomp);
part-one(@input-file);
part-two(@input-file);
