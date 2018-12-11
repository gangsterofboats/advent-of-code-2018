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
use MONKEY-SEE-NO-EVAL;

# Function definitions

sub part-one(@input)
{
    my @lights;
    my $max-x = -1000000;
    my $min-x = 1000000;
    my $max-y = -1000000;
    my $min-y = 1000000;
    my $time-to-take = 0;
    my ($i-max-x, $i-min-x, $i-max-y, $i-min-y) = (0, 0, 0, 0);

    for @input -> $line
    {
        my $l = $line.subst('=<', ' => [', :g);
        $l .= subst('> v', '], v', :g);
        $l .= subst(/\>$/, ']}', :g);
        $l .= subst(/^p/, '{p', :g);
        @lights.push(EVAL $l);
    }
    for @lights.kv -> $i, %lgt
    {
        if (%lgt{'position'}[0] > $max-x)
        {
            $max-x = %lgt{'position'}[0];
            $i-max-x = $i;
        }
        if (%lgt{'position'}[0] < $min-x)
        {
            $min-x = %lgt{'position'}[0];
            $i-min-x = $i;
        }
        if (%lgt{'position'}[1] > $max-y)
        {
            $max-y = %lgt{'position'}[1];
            $i-max-y = $i;
        }
        if (%lgt{'position'}[0] < $min-y)
        {
            $min-y = %lgt{'position'}[1];
            $i-min-y = $i;
        }
    }
    my $x0 = @lights[$i-max-x]{'position'}[0];
    my $x1 = @lights[$i-min-x]{'position'}[0];
    my $y0 = @lights[$i-max-y]{'position'}[1];
    my $y1 = @lights[$i-min-y]{'position'}[1];
    my $box = 1;
    while ($box > 0)
    {
        $x0 += @lights[$i-max-x]{'velocity'}[0];
        $x1 += @lights[$i-min-x]{'velocity'}[0];
        $y0 += @lights[$i-max-y]{'velocity'}[1];
        $y1 += @lights[$i-min-y]{'velocity'}[1];
        $time-to-take += 1;
        $box = ($x0 - $x1) * ($y0 - $y1);
    }
    for (1..$time-to-take + 1) -> $j
    {
        my @lights-map;
        for (0..200) -> $ya
        {
            for (0..300) -> $xa
            {
                @lights-map[$ya][$xa] = '.';
            }
        }
        for @lights -> %light
        {
            %light{'position'}[0] += %light{'velocity'}[0];
            %light{'position'}[1] += %light{'velocity'}[1];
            my $x-index = %light{'position'}[0];
            my $y-index = %light{'position'}[1];
            if ($j == $time-to-take)
            {
                @lights-map[$y-index][$x-index] = '#';
            }
        }
        if ($j == $time-to-take)
        {
            my @parr = [];
            for @lights-map -> @ln
            {
                my $row = @ln.join('');
                @parr.push($row);
            }
            spurt 'map.txt', @parr.join("\n")
        }
    }
}

sub part-two(@input)
{
        my @lights;
    my $max-x = -1000000;
    my $min-x = 1000000;
    my $max-y = -1000000;
    my $min-y = 1000000;
    my $time-to-take = 0;
    my ($i-max-x, $i-min-x, $i-max-y, $i-min-y) = (0, 0, 0, 0);

    for @input -> $line
    {
        my $l = $line.subst('=<', ' => [', :g);
        $l .= subst('> v', '], v', :g);
        $l .= subst(/\>$/, ']}', :g);
        $l .= subst(/^p/, '{p', :g);
        @lights.push(EVAL $l);
    }
    for @lights.kv -> $i, %lgt
    {
        if (%lgt{'position'}[0] > $max-x)
        {
            $max-x = %lgt{'position'}[0];
            $i-max-x = $i;
        }
        if (%lgt{'position'}[0] < $min-x)
        {
            $min-x = %lgt{'position'}[0];
            $i-min-x = $i;
        }
        if (%lgt{'position'}[1] > $max-y)
        {
            $max-y = %lgt{'position'}[1];
            $i-max-y = $i;
        }
        if (%lgt{'position'}[0] < $min-y)
        {
            $min-y = %lgt{'position'}[1];
            $i-min-y = $i;
        }
    }
    my $x0 = @lights[$i-max-x]{'position'}[0];
    my $x1 = @lights[$i-min-x]{'position'}[0];
    my $y0 = @lights[$i-max-y]{'position'}[1];
    my $y1 = @lights[$i-min-y]{'position'}[1];
    my $box = 1;
    while ($box > 0)
    {
        $x0 += @lights[$i-max-x]{'velocity'}[0];
        $x1 += @lights[$i-min-x]{'velocity'}[0];
        $y0 += @lights[$i-max-y]{'velocity'}[1];
        $y1 += @lights[$i-min-y]{'velocity'}[1];
        $time-to-take += 1;
        $box = ($x0 - $x1) * ($y0 - $y1);
    }
    say $time-to-take;
}


my $filename = 'day-10-input.txt';
my @input-file = $filename.IO.lines(:chomp);

part-one(@input-file); # HRPHBRKG
part-two(@input-file); # 10355
