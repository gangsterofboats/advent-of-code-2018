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

sub part-one(Int $num)
{
    my @recipes = (3,7);
    my $elf-a = 0;
    my $elf-b = 1;

    while (@recipes.elems < ($num + 10))
    {
        my $rcp = @recipes[$elf-a] + @recipes[$elf-b];
        if ($rcp >= 10)
        {
            my ($f, $s) = split('', Str($rcp), :skip-empty);
            @recipes.push: Int($f), Int($s);
        }
        else
        {
            @recipes.push: $rcp;
        }
        $elf-a = (@recipes[$elf-a] + 1 + $elf-a) % (@recipes.elems);
        $elf-b = (@recipes[$elf-b] + 1 + $elf-b) % (@recipes.elems);
    }
    say @recipes[*-10..*-1].join('');
}

sub part-two(Int $num)
{
    my @recipes = (3,7);
    my $elf-a = 0;
    my $elf-b = 1;
    my $stop = False;

    while ($stop.not)
    {
        my $rcp = @recipes[$elf-a] + @recipes[$elf-b];
        if ($rcp >= 10)
        {
            my ($f, $s) = split('', Str($rcp), :skip-empty);
            @recipes.push: Int($f), Int($s);
        }
        else
        {
            @recipes.push: $rcp;
        }
        $elf-a = (@recipes[$elf-a] + 1 + $elf-a) % (@recipes.elems);
        $elf-b = (@recipes[$elf-b] + 1 + $elf-b) % (@recipes.elems);
        if ((@recipes.elems > 6) and (@recipes[*-6..*-1].join('') eq Str($num)))
        {
            $stop = True;
        }
    }
    say (@recipes.elems - 6);
}

my $input-no = 919901;

# part-one($input-no); # 7861362411
part-two($input-no); # 20203532
