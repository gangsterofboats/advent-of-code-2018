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
    my $polymers = $input;
    my @letter_pairs;
    for ('a'..'z') -> $ltr
    {
        @letter_pairs.push: $ltr ~ $ltr.uc;
        @letter_pairs.push: $ltr.uc ~ $ltr;
    }
    my $found = True;
    while ($found eq True)
    {
        for @letter_pairs -> $pair
        {
            $polymers .= subst(/$pair/, "", :g);
        }
        my $lpct = 0;
        for @letter_pairs -> $lp
        {
            $lpct += 1 if not $polymers.match($lp);
            $found = False if $lpct == 52;
        }
    }
    say $polymers.chars;
}

sub part-two(Str $input)
{
    my $polymers = $input;
    my @letter_pairs;
    my %letter_strprs;
    for ('a'..'z') -> $ltr
    {
        @letter_pairs.push: $ltr ~ $ltr.uc;
        @letter_pairs.push: $ltr.uc ~ $ltr;
        my $ucltr = $ltr.uc;
        # %letter_strprs{$ltr} = $polymers ~~ s:g/$ltr|$ucltr//;
        # $polymers ~~ s:gr/$ltr|$ucltr//;
        my $plmrs = $polymers.trans($ltr => '');
        $plmrs .= trans($ltr.uc => '');
        %letter_strprs{$ltr} = $plmrs;
    }
    my $shortest_chain = 50000;
    for %letter_strprs.kv -> $key, $value
    {
        my $v = $value;
        my $found = True;
        while ($found eq True)
        {
            for @letter_pairs -> $pair
            {
                $v ~~ s:g/$pair//;
            }
            my $lpct = 0;
            for @letter_pairs -> $lp
            {
                $lpct += 1 if not $polymers.match($lp);
                $found = False if $lpct == 52;
            }
        }
        $shortest_chain = $value.chars if $shortest_chain > $value.chars;
    }
    say $shortest_chain;
}

my $filename = 'day-5-input.txt';
my $input-line = $filename.IO.lines(:chomp)[0];
part-one($input-line); # 11364
part-two($input-line); # 4212
