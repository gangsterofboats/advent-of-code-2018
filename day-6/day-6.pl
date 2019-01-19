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
use v5.28;
use Data::Dumper;
use List::Util qw(first none);

# Function definitions
sub part_one
{
    my @pts = @{$_[0]};
    my @point_map;
    push @point_map, [('#') x 400] for (0..399);
    my @points;
    for my $pt (@pts)
    {
        my ($x, $y) = split(/, /, $pt);
        push @points, [$x, $y];
    }
    for my $x_pt (0..399)
    {
        for my $y_pt (0..399)
        {
            my $not_eq_distance = 'true';
            my $min_distance = 100000;
            my $name = '';
            for my $p (@points)
            {
                my $distance = abs($p->[0] - $x_pt) + abs($p->[1] - $y_pt);
                if ($distance < $min_distance)
                {
                    $min_distance = $distance;
                    $name = first {$points[$_] eq $p} 0..$#points;
                    $not_eq_distance = 'true';
                }
                elsif ($distance == $min_distance)
                {
                    $not_eq_distance = 'false';
                }
            }
            if ($not_eq_distance eq 'true')
            {
                $point_map[$y_pt][$x_pt] = $name;
            }
        }
    }
    my @removed_points;
    for my $axis (0..399)
    {
        push @removed_points, $point_map[0][$axis] if none {$_ eq $point_map[0][$axis]} @removed_points;
        push @removed_points, $point_map[$axis][0] if none {$_ eq $point_map[$axis][0]} @removed_points;
        push @removed_points, $point_map[399][$axis] if none {$_ eq $point_map[399][$axis]} @removed_points;
        push @removed_points, $point_map[$axis][399] if none {$_ eq $point_map[$axis][399]} @removed_points;
    }
    my @ps = (0) x 50;
    for my $y_coord (0..399)
    {
        for my $x_coord (0..399)
        {
            if (($point_map[$y_coord][$x_coord] ne '*') && (none {$_ eq $point_map[$y_coord][$x_coord]} @removed_points))
            {
                my $i = $point_map[$y_coord][$x_coord];
                $ps[$i] += 1;
            }
        }
    }
    my $top = 0;
    for my $v (@ps)
    {
        $top = $v if $v > $top;
    }
    say $top;
}

sub part_two
{
    my @pts = @{$_[0]};
    my @point_map;
    push @point_map, [('#') x 400] for (0..399);
    my @points;
    for my $pt (@pts)
    {
        my ($x, $y) = split(/, /, $pt);
        push @points, [$x, $y];
    }
    my $region_area = 0;
    for my $y_axis (0..399)
    {
        for my $x_axis (0..399)
        {
            my $total_dist = 0;
            for my $p (@points)
            {
                my $distance = abs($p->[0] - $x_axis) + abs($p->[1] - $y_axis);
                $total_dist += $distance;
            }
            $region_area += 1 if $total_dist < 10000;
        }
    }
    say $region_area;
}

my $filename = 'day-6-input.txt';
open(my $ifh, '<', $filename);
my @input = <$ifh>;
close $ifh;
chomp(@input);
part_one(\@input); # 4016
part_two(\@input); # 46306
