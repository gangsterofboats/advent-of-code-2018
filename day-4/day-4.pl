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
use v5.28;
use DateTime::Format::Strptime;
use Data::Dumper;

# Part One
sub part_one
{
    my @input = @{$_[0]};
    my $guard_id = '';
    my %total_sleep_time;
    my %sleep_range;
    my %timestamp = ('asleep' => '', 'wakeup' => '');
    for my $line (@input)
    {
        if ($line =~ 'shift')
        {
            my @mth = $line =~ /#(\d+)/g;
            $guard_id = $mth[0];
            $total_sleep_time{$guard_id} = 0 if not defined $total_sleep_time{$guard_id};
            $sleep_range{$guard_id} = [] if not defined $sleep_range{$guard_id};
        }
        elsif ($line =~ 'asleep')
        {
            my ($dt, $action) = split(/\]/, $line);
            $dt = substr($dt, 1);
            my $strp = DateTime::Format::Strptime->new(pattern => '%Y-%m-%d %H:%M');
            $timestamp{'asleep'} = $strp->parse_datetime($dt);
        }
        elsif ($line =~ 'wakes')
        {
            my ($dt, $action) = split(/\]/, $line);
            $dt = substr($dt, 1);
            my $strp = DateTime::Format::Strptime->new(pattern => '%Y-%m-%d %H:%M');
            $timestamp{'wakeup'} = $strp->parse_datetime($dt);
            my $time_asleep = $timestamp{'wakeup'} - $timestamp{'asleep'};
            push @{$sleep_range{$guard_id}}, ($timestamp{'asleep'}->minute .. $timestamp{'wakeup'}->minute);
            $total_sleep_time{$guard_id} += $time_asleep->minutes;
        }
    }
    my $gid = 0;
    my $total = 0;
    while (my ($key, $value) = each %total_sleep_time)
    {
        if ($value > $total)
        {
            $gid = $key;
            $total = $value;
        }
    }
    my %minutes = map {$_ => 0} (0..59);
    for my $sr (@{$sleep_range{$gid}})
    {
        $minutes{$sr} += 1
    }
    # foreach my $mnt (sort {$minutes{$a} <=> $minutes{$b}} keys %minutes)
    # {
        # printf "%s %s\n", $mnt, $minutes{$mnt};
    # }
    say $gid * 25;
}

sub part_two
{
    my @input = @{$_[0]};
    my $guard_id = 0;
    my %guards;
    my %guard_mode_time;
    my $asleep = '';
    my $wakeup = '';
    for my $line (@input)
    {
        if ($line =~ 'shift')
        {
            my @mth = $line =~ /#(\d+)/g;
            $guard_id = $mth[0];
            $guards{$guard_id} = [0, 0, 0] if not defined $guards{$guard_id};
            $guard_mode_time{$guard_id} = () if not defined $guard_mode_time{$guard_id};
        }
        elsif ($line =~ 'asleep')
        {
            my ($dt, $action) = split(/\]/, $line);
            $dt = substr($dt, 1);
            my $strp = DateTime::Format::Strptime->new(pattern => '%Y-%m-%d %H:%M');
            $asleep = $strp->parse_datetime($dt);
        }
        elsif ($line =~ 'wakes')
        {
            my ($dt, $action) = split(/\]/, $line);
            $dt = substr($dt, 1);
            my $strp = DateTime::Format::Strptime->new(pattern => '%Y-%m-%d %H:%M');
            $wakeup = $strp->parse_datetime($dt);
            my $time_asleep = $wakeup - $asleep;
            push @{$guard_mode_time{$guard_id}}, ($asleep->minute .. $wakeup->minute);
            $guards{$guard_id}[0] += $time_asleep->minutes;
        }
    }
    while (my ($key, $value) = each %guard_mode_time)
    {
        my %minutes = map {$_ => 0} (0..59);
        for my $sr (@{$value})
        {
            $minutes{$sr} += 1;
        }
        while (my ($f, $s) = each %minutes)
        {
            if ($guards{$key}[2] < $s)
            {
                $guards{$key}[1] = $f;
                $guards{$key}[2] = $s;
            }
        }
    }
    my $most_freq = 0;
    my $mint = 0;
    my $gid = 0;
    while (my ($g, $d) = each %guards)
    {
        if ($d->[2] > $most_freq)
        {
            $gid = $g;
            $mint = $d->[1];
            $most_freq = $d->[2];
        }
    }
    say $gid * ($mint - 1);
}

# Sorted the lines when saving the input file
my $filename = 'day-4-input.txt';
open(my $ifh, '<', $filename);
my @input_file = <$ifh>;
close $ifh;
chomp(@input_file);
part_one(\@input_file); # 2917 * 25 = 72925
part_two(\@input_file); # 1489 * 33 = 49137
