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
use Data::Dumper;

# Function definitions

sub part_one
{
    my @input = @{$_[0]};
    my @s_input = sort @input;
    my %letter_pairs_forward;
    my %letter_pairs_backward;
    my @letters = 'A'..'Z';
    my $middle = ' must be finished before step ';

    for my $line (@s_input)
    {
        my $aline = $line =~ s/$middle/=>/r;
        $aline =~ s/Step //;
        $aline =~ s/ can begin\.//;
        my ($f, $s) = split /=>/, $aline;
        unless (exists $letter_pairs_forward{$f})
        {
            $letter_pairs_forward{$f} = [$s];
        }
        else
        {
            push @{$letter_pairs_forward{$f}}, $s;
        }
        unless (exists $letter_pairs_backward{$s})
        {
            $letter_pairs_backward{$s} = [$f];
        }
        else
        {
            push @{$letter_pairs_backward{$s}}, $f;
        }
    }
    for my $ltr (@letters)
    {
        if (defined $letter_pairs_backward{$ltr})
        {
            say $ltr, ': [', join(', ', @{$letter_pairs_backward{$ltr}}), ']';
        }
        else
        {
            say "$ltr: []";
        }

    }
}

# sub part_two
# {
# }

# Did both parts with pencil and paper mostly

my $filename = 'day-7-input.txt';
open(my $ifh, '<', $filename);
my @input_file = <$ifh>;
close $ifh;
chomp(@input_file);
part_one(\@input_file);
# part_two(\@input_file);
