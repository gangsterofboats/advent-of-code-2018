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
use List::Util 'max';

# Function definitions

sub part_one
{
    my $input = shift;
    my ($players, $num_of_marbs) = $input =~ /\d+/g;
    my @player_points = (0) x $players;
    my $curr_player = 0;
    my @circle = (0, 1);
    my $cidx = 0;

    for my $i (2..$num_of_marbs)
    {
        if ($i % 23 == 0)
        {
            $player_points[$curr_player] += $i;
            $cidx = ($cidx - 7) % @circle;
            $player_points[$curr_player] += $circle[$cidx];
            splice(@circle, $cidx, 1);
        }
        else
        {
            $cidx = ($cidx + 2) % @circle;
            splice(@circle, $cidx, 0, $i);
        }
        $curr_player = ($curr_player + 1) % $players;
    }
    say max(@player_points);
}

sub part_two
{
    my $input = shift;
    my ($players, $num_of_marbs) = $input =~ /\d+/g;
    $num_of_marbs = $num_of_marbs * 100;
    my @player_points = (0) x $players;
    my $curr_player = 0;
    my @circle = (0, 1);
    my $cidx = 0;

    for my $i (2..$num_of_marbs)
    {
        if ($i % 23 == 0)
        {
            $player_points[$curr_player] += $i;
            $cidx = ($cidx - 7) % @circle;
            $player_points[$curr_player] += $circle[$cidx];
            splice(@circle, $cidx, 1);
        }
        else
        {
            $cidx = ($cidx + 2) % @circle;
            splice(@circle, $cidx, 0, $i);
        }
        $curr_player = ($curr_player + 1) % $players;
    }
    say max(@player_points);
}

my $filename = 'day-9-input.txt';
open(my $ifh, '<', $filename);
my $input_file = <$ifh>;
close $ifh;
chomp($input_file);
part_one($input_file); # 428690
part_two($input_file); # 3628143500
