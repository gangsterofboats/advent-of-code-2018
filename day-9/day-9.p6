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

# Function definitions

sub part-one(Str $input)
{
    my ($players, $num-of-marbs) = $input ~~ m:g/\d+/;
    ($players, $num-of-marbs) = $players.Int, $num-of-marbs.Int;
    my @player-points;
    for (0..^$players) -> $z
    {
        @player-points[$z] = 0;
    }
    my $curr-player = 0;
    my @circle = (0, 1);
    my $cidx = 0;

    for (2..$num-of-marbs) -> $i
    {
        if ($i % 23 == 0)
        {
            @player-points[$curr-player] += $i;
            $cidx = ($cidx - 7) % @circle;
            @player-points[$curr-player] += @circle[$cidx];
            splice(@circle, $cidx, 1);
        }
        else
        {
            $cidx = ($cidx + 2) % @circle;
            splice(@circle, $cidx, 0, $i);
        }
        $curr-player = ($curr-player + 1) % $players;
    }
    say max(@player-points);
}

sub part-two(Str $input)
{
    my ($players, $num-of-marbs) = $input ~~ m:g/\d+/;
    ($players, $num-of-marbs) = $players.Int, $num-of-marbs.Int;
    $num-of-marbs = $num-of-marbs * 100;
    my @player-points;
    for (0..^$players) -> $z
    {
        @player-points[$z] = 0;
    }
    my $curr-player = 0;
    my @circle = (0, 1);
    my $cidx = 0;

    for (2..$num-of-marbs) -> $i
    {
        if ($i % 23 == 0)
        {
            @player-points[$curr-player] += $i;
            $cidx = ($cidx - 7) % @circle;
            @player-points[$curr-player] += @circle[$cidx];
            splice(@circle, $cidx, 1);
        }
        else
        {
            $cidx = ($cidx + 2) % @circle;
            splice(@circle, $cidx, 0, $i);
        }
        $curr-player = ($curr-player + 1) % $players;
    }
    say max(@player-points);
}

my $filename = 'day-9-input.txt';
my $input-file = $filename.IO.lines(:chomp)[0];
part-one($input-file); # 428690
part-two($input-file); # 3628143500
