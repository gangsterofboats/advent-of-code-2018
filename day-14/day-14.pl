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
use v5.28;
use common::sense;
use Data::Dumper;
# Function definitions

sub part_one
{
    my $num = shift;
    my @recipes = (3,7);
    my $elf_a = 0;
    my $elf_b = 1;

    while (scalar @recipes < ($num + 10))
    {
        my $rcp = $recipes[$elf_a] + $recipes[$elf_b];
        if ($rcp >= 10)
        {
            my ($f, $s) = split(//, $rcp);
            push @recipes, $f, $s;
        }
        else
        {
            push @recipes, $rcp;
        }
        $elf_a = ($recipes[$elf_a] + 1 + $elf_a) % (scalar @recipes);
        $elf_b = ($recipes[$elf_b] + 1 + $elf_b) % (scalar @recipes);
    }
    say @recipes[-10..-1];
}

sub part_two
{
    my $num = shift;
    my @recipes = (3,7);
    my $elf_a = 0;
    my $elf_b = 1;
    my $stop = 'false';

    while ($stop eq 'false')
    {
        my $rcp = $recipes[$elf_a] + $recipes[$elf_b];
        if ($rcp >= 10)
        {
            my ($f, $s) = split(//, $rcp);
            push @recipes, $f, $s;
        }
        else
        {
            push @recipes, $rcp;
        }
        $elf_a = ($recipes[$elf_a] + 1 + $elf_a) % (scalar @recipes);
        $elf_b = ($recipes[$elf_b] + 1 + $elf_b) % (scalar @recipes);
        if ((scalar @recipes > 6) and (@recipes[-6..-1] eq $num))
        {
            $stop = 'true';
        }
    }
    say (scalar @recipes - 6);
}

my $input_no = 919901;

# part_one($input_no); # 7861362411
part_two($input_no); # 20203532
