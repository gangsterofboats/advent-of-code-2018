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
use List::Util qw[max sum];
use Data::Dumper;

# Function definitions

sub sum_square
{
    my @square = @{+shift};
    my $x = shift;
    my $y = shift;
    my $increase = shift;
    my $sum = 0;

    for my $i ($y..$y + $increase)
    {
        for my $j ($x..$x + $increase)
        {
            $sum += $square[$i][$j];
        }
    }
    return $sum;
}

sub part_one
{
    my $input = shift;
    my @fuel_cell_map;
    push @fuel_cell_map, [(0) x 300] for (0..299);
    for my $y_axis (1..300)
    {
        for my $x_axis (1..30)
        {
            my $rack_ID = $x_axis + 10;
            my $power_level = $rack_ID * $y_axis;
            $power_level += $input;
            $power_level = $power_level * $rack_ID;
            if ($power_level > 100)
            {
                $power_level = int(($power_level % 1000) / 100);
            }
            else
            {
                $power_level = 0;
            }
            $power_level -= 5;
            $fuel_cell_map[$y_axis][$x_axis] = $power_level;
        }
    }
    my $max_corner = max(map {@$_} @fuel_cell_map);
    my @max_square;
    my $max_power = 0;
    for my $y (0..299)
    {
        for my $x (0..299)
        {
            if (($fuel_cell_map[$y][$x] == $max_corner) and (0 <= $x and $x <= 297) and (0 <= $y and $y <= 297))
            {
                my $power = sum_square(\@fuel_cell_map, $x, $y, 2);
                if ($max_power < $power)
                {
                    $max_power = $power;
                    @max_square = ($x, $y);
                }
            }
        }
    }
    say "$max_square[0],$max_square[1]";
}

sub part_two
{
    my $input = shift;
    my @fuel_cell_map;
    push @fuel_cell_map, [(0) x 300] for (0..299);
    for my $y_axis (1..300)
    {
        for my $x_axis (1..30)
        {
            my $rack_ID = $x_axis + 10;
            my $power_level = $rack_ID * $y_axis;
            $power_level += $input;
            $power_level = $power_level * $rack_ID;
            if ($power_level > 100)
            {
                $power_level = int(($power_level % 1000) / 100);
            }
            else
            {
                $power_level = 0;
            }
            $power_level -= 5;
            $fuel_cell_map[$y_axis][$x_axis] = $power_level;
        }
    }
    my $max_corner = max(map {@$_} @fuel_cell_map);
    my @max_square;
    my $max_power = 0;
    for my $sz (1..300)
    {
        for my $y (0..299)
        {
            for my $x (0..299)
            {
                if ((0 <= $x and $x <= 299 - $sz) and (0 <= $y and $y <= 299 - $sz))
                {
                    my $power = sum_square(\@fuel_cell_map, $x, $y, $sz);
                    if ($max_power < $power)
                    {
                        $max_power = $power;
                        @max_square = ($x, $y, $sz);
                        say "@max_square";
                    }
                }
            }
        }
    }
}

my $input_no = 6878;

part_one($input_no); # 20,34
part_two($input_no); # 90,57,15
