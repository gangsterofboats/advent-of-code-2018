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
use common::sense;
use v5.28;
use Hash::DefaultValue;
use List::Util qw(min max);

# Function definitions
sub part_one
{
    my @ipt = @{$_[0]};
    my $inst = $ipt[0];
    $inst =~ s/^.*: //;
    my @initial_state = split //, $inst;
    my %rules;
    for my $line (2..$#ipt)
    {
        my ($key, $value) = split / => /, $ipt[$line];
        $rules{$key} = $value;
    }
    tie my %gen, 'Hash::DefaultValue', '.';
    for my $p (0..(length $inst) - 1)
    {
        $gen{$p} = $initial_state[$p];
    }
    for (1..20)
    {
        my %next_gen;
        my $min_pot = (min (keys %gen)) - 2;
        my $max_pot = (max (keys %gen)) + 2;
        for my $pot ($min_pot .. $max_pot)
        {
            my $plant_state;
            for my $s ($pot - 2 .. $pot + 2)
            {
                $plant_state .= $gen{$s};
            }
            $next_gen{$pot} = $rules{$plant_state};
        }
        %gen = %next_gen;
    }
    my $sum = 0;
    while (my ($k, $v) = each %gen)
    {
        if ($v eq '#')
        {
            $sum += $k;
        }
    }
    say $sum;
}

sub part_two
{
    my @ipt = @{$_[0]};
    my $inst = $ipt[0];
    $inst =~ s/^.*: //;
    my @initial_state = split //, $inst;
    my %rules;
    for my $line (2..$#ipt)
    {
        my ($key, $value) = split / => /, $ipt[$line];
        $rules{$key} = $value;
    }
    tie my %gen, 'Hash::DefaultValue', '.';
    for my $p (0..(length $inst) - 1)
    {
        $gen{$p} = $initial_state[$p];
    }
    for (1..50000000000)
    {
        my %next_gen;
        my $min_pot = (min (keys %gen)) - 2;
        my $max_pot = (max (keys %gen)) + 2;
        for my $pot ($min_pot .. $max_pot)
        {
            my $plant_state;
            for my $s ($pot - 2 .. $pot + 2)
            {
                $plant_state .= $gen{$s};
            }
            $next_gen{$pot} = $rules{$plant_state};
        }
        %gen = %next_gen;
    }
    my $sum = 0;
    while (my ($k, $v) = each %gen)
    {
        if ($v eq '#')
        {
            $sum += $k;
        }
    }
    say $sum;
}

my $filename = 'day-12-input.txt';
open(my $ifh, '<', $filename);
my @input_file = <$ifh>;
close $ifh;
chomp(@input_file);

part_one(\@input_file); # 3405
part_two(\@input_file); # 3350000000000
