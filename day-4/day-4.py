#!/usr/bin/env python
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
from collections import defaultdict
from datetime import datetime
import re

# Function definitions

def part_one(input):
    guard_id = 0
    guards = defaultdict(list)
    guard_mode_time = defaultdict(list)
    asleep = ''
    wakeup = ''

    for line in input:
        if 'shift' in line:
            pattern = re.compile('#\d+')
            result = pattern.search(line)[0]
            guard_id = int(result[1:])
            if len(guards[guard_id]) == 0:
                guards[guard_id] = [0, 0, 0]
        elif 'asleep' in line:
            (dt, action) = line.split(']')
            dt = dt[1:]
            asleep = datetime.strptime(dt, '%Y-%m-%d %H:%M')
        elif 'wakes' in line:
            (dt, action) = line.split(']')
            dt = dt[1:]
            wakeup = datetime.strptime(dt, '%Y-%m-%d %H:%M')
            time_asleep = wakeup - asleep
            guard_mode_time[guard_id].extend(list(range(asleep.minute, wakeup.minute)))
            guards[guard_id][0] += int(time_asleep.seconds/60)

    for key, value in guard_mode_time.items():
        minutes = dict.fromkeys(list(range(0, 60)), 0)
        for v in value:
            minutes[v] += 1
        for f, s in minutes.items():
            if guards[key][2] < s:
                guards[key][1] = f
                guards[key][2] = s

    gid = 0
    total = 0
    mint = 0
    for gd, io in guards.items():
        if guards[gd][0] > total:
            total = guards[gd][0]
            gid = gd
            mint = guards[gd][1]

    print(gid * mint)

def part_two(input):
    guard_id = 0
    guards = defaultdict(list)
    guard_mode_time = defaultdict(list)
    asleep = ''
    wakeup = ''

    for line in input:
        if 'shift' in line:
            pattern = re.compile('#\d+')
            result = pattern.search(line)[0]
            guard_id = int(result[1:])
            if len(guards[guard_id]) == 0:
                guards[guard_id] = [0, 0, 0]
        elif 'asleep' in line:
            (dt, action) = line.split(']')
            dt = dt[1:]
            asleep = datetime.strptime(dt, '%Y-%m-%d %H:%M')
        elif 'wakes' in line:
            (dt, action) = line.split(']')
            dt = dt[1:]
            wakeup = datetime.strptime(dt, '%Y-%m-%d %H:%M')
            time_asleep = wakeup - asleep
            guard_mode_time[guard_id].extend(list(range(asleep.minute, wakeup.minute)))
            guards[guard_id][0] += int(time_asleep.seconds/60)

    for key, value in guard_mode_time.items():
        minutes = dict.fromkeys(list(range(0, 60)), 0)
        for v in value:
            minutes[v] += 1
        for f, s in minutes.items():
            if guards[key][2] < s:
                guards[key][1] = f
                guards[key][2] = s

    gid = 0
    most_freq = 0
    mint = 0
    for gd, io in guards.items():
        if guards[gd][2] > most_freq:
            most_freq = guards[gd][2]
            gid = gd
            mint = guards[gd][1]

    print(gid * mint)

# Import data and execute functions

# Sorted the lines when saving the input file
input_file = open('day-4-input.txt', 'r').read().splitlines()
part_one(input_file) # 2917 * 25 = 72925
part_two(input_file) # 49137
