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

# Part One
sub part-one(@input)
{
    my $guard-id;
    my %total-sleep-time;
    my %sleep-range;
    my %timestamp = 'asleep' => '', 'wakeup' => '';
    for @input -> $line
    {
        if $line.contains('shift')
        {
            my @mth = $line.comb(/\#\d+/);
            $guard-id = @mth[0].substr(1..*);
            %total-sleep-time{$guard-id} = 0 if not %total-sleep-time{$guard-id}.defined;
            %sleep-range{$guard-id} = [] if not %sleep-range{$guard-id}.defined;
        }
        elsif $line.contains('asleep')
        {
            my @mth = $line.comb(/\d+/);
            my $dt = DateTime.new(
                year   => @mth[0],
                month  => @mth[1],
                day    => @mth[2],
                hour   => @mth[3],
                minute => @mth[4]
            );
            %timestamp{'asleep'} = $dt;
        }
        elsif $line.contains('wakes')
        {
            my @mth = $line.comb(/\d+/);
            my $dt = DateTime.new(
                year   => @mth[0],
                month  => @mth[1],
                day    => @mth[2],
                hour   => @mth[3],
                minute => @mth[4]
            );
            %timestamp{'wakeup'} = $dt;
            my $time-asleep = %timestamp{'wakeup'} - %timestamp{'asleep'};
            %sleep-range{$guard-id}.append: (%timestamp{'asleep'}.minute .. %timestamp{'wakeup'}.minute).list;
            %total-sleep-time{$guard-id} += $time-asleep;
        }
    }
    my $gid = 0;
    my $total = 0;
    for %total-sleep-time.kv -> $k, $v
    {
        if $v > $total
        {
            $gid = $k;
            $total = $v;
        }
    }
    my %minutes;
    for (0..59) -> $i
    {
        %minutes{$i} = 0;
    }
    for @(%sleep-range{$gid}) -> $sr
    {
        %minutes{$sr} += 1;
    }
    # say %minutes;
    say $gid * 25;
}

sub part-two(@input)
{
    my $guard-id = 0;
    my %guards;
    my %guard-mode-time;
    my $asleep = '';
    my $wakeup = '';
    for @input -> $line
    {
        if $line.contains('shift')
        {
            my @mth = $line.comb(/\#\d+/);
            $guard-id = @mth[0].substr(1..*);
            %guards{$guard-id} = [0, 0, 0] if not %guards{$guard-id}.defined;
            %guard-mode-time{$guard-id} = [] if not %guard-mode-time{$guard-id}.defined;
        }
        elsif $line.contains('asleep')
        {
            my @mth = $line.comb(/\d+/);
            my $dt = DateTime.new(
                year   => @mth[0],
                month  => @mth[1],
                day    => @mth[2],
                hour   => @mth[3],
                minute => @mth[4]
            );
            $asleep = $dt;
        }
        elsif $line.contains('wakes')
        {
            my @mth = $line.comb(/\d+/);
            my $dt = DateTime.new(
                year   => @mth[0],
                month  => @mth[1],
                day    => @mth[2],
                hour   => @mth[3],
                minute => @mth[4]
            );
            $wakeup = $dt;
            my $time-asleep = $wakeup - $asleep;
            %guard-mode-time{$guard-id}.append: ($asleep.minute .. $wakeup.minute).list;
            %guards{$guard-id}[0] += $time-asleep;
        }
    }
    for %guard-mode-time.kv -> $key, $value
    {
        my %minutes;
        for (0..59) -> $i
        {
            %minutes{$i} = 0;
        }
        for @($value) -> $sr
        {
            %minutes{$sr} += 1;
        }
        for %minutes.kv -> $f, $s
        {
            if (%guards{$key}[2] < $s)
            {
                %guards{$key}[1] = $f;
                %guards{$key}[2] = $s;
            }
        }
    }
    my $most-freq = 0;
    my $mint = 0;
    my $gid = 0;
    for %guards.kv -> $g, $d
    {
        if ($d.[2] > $most-freq)
        {
            $gid = $g;
            $mint = $d.[1];
            $most-freq = $d.[2];
        }
    }
    say ($gid * $mint);
}

# Sorted the lines when saving the input file
my $filename = 'day-4-input.txt';
my @input-file = $filename.IO.lines(:chomp);
part-one(@input-file); # 2917 * 25 = 72925
part-two(@input-file); # 1489 * 33 = 49137
