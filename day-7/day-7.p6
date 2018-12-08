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

sub part-one(@input)
{
    my @s_input = @input.sort;
    my %letter_pairs_forward;
    my %letter_pairs_backward;
    my @letters = 'A'..'Z';
    my $middle = ' must be finished before step ';
    for @s_input -> $line
    {
        my $aline = $line.subst(/$middle/, '=>');
        $aline .= subst(/Step' '/, '');
        $aline .= subst(' can begin.', '');
        my ($f, $s) = $aline.split('=>');
        if not %letter_pairs_forward{$f}:exists
        {
            %letter_pairs_forward{$f} = [$s];
        }
        else
        {
            %letter_pairs_forward{$f}.push($s);
        }
        if not %letter_pairs_backward{$s}:exists
        {
            %letter_pairs_backward{$s} = [$f];
        }
        else
        {
            %letter_pairs_backward{$s}.push($f);
        }
    }
    for @letters -> $ltr
    {
        if not %letter_pairs_forward{$ltr}:exists
        {
            %letter_pairs_forward{$ltr} = [];
        }
        if not %letter_pairs_backward{$ltr}:exists
        {
            %letter_pairs_backward{$ltr} = [];
        }
    }
    say %letter_pairs_backward;
}

# sub part-two(@input)
# {
# }

# Did both parts with pencil and paper mostly

my $filename = 'day-7-input.txt';
my @input-file = $filename.IO.lines(:chomp);
part-one(@input-file); # BGKDMJCNEQRSTUZWHYLPAFIVXO
# part-two(@input-file); # 941
