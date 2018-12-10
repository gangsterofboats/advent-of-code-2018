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
import json
import re

# Function definitions

def part_one(input):
    lights = []
    max_x = -1000000
    min_x = 1000000
    max_y = -1000000
    min_y = 1000000
    time_to_take = 0
    i_max_x, i_min_x, i_max_y, i_min_y = 0, 0, 0, 0

    for l in input:
        line = re.sub('=<', '": [', l)
        line = re.sub('> ', '], "', line)
        line = re.sub(r'>$', ']}', line)
        line = '{"' + line
        lights.append(eval(line))

    for i, lgt in enumerate(lights):
        if lgt['position'][0] > max_x:
            max_x = lgt['position'][0]
            i_max_x = i
        if lgt['position'][0] < min_x:
            min_x = lgt['position'][0]
            i_min_x = i
        if lgt['position'][1] > max_y:
            max_y = lgt['position'][1]
            i_max_y = i
        if lgt['position'][0] < min_y:
            min_y = lgt['position'][1]
            i_min_y = i

    x0 = lights[i_max_x]['position'][0]
    x1 = lights[i_min_x]['position'][0]
    y0 = lights[i_max_y]['position'][1]
    y1 = lights[i_min_y]['position'][1]
    box = 1
    while box > 0:
        x0 += lights[i_max_x]['velocity'][0]
        x1 += lights[i_min_x]['velocity'][0]
        y0 += lights[i_max_y]['velocity'][1]
        y1 += lights[i_min_y]['velocity'][1]
        time_to_take += 1
        box = (x0 - x1) * (y0 - y1)

    for j in range(1, time_to_take + 2):
        lights_map = []
        for x_row in range(200):
            lights_map.append(['.'] * 300)
        for light in lights:
            light['position'][0] += light['velocity'][0]
            light['position'][1] += light['velocity'][1]
            x_index = light['position'][0]
            y_index = light['position'][1]
            if j == (time_to_take):
                lights_map[y_index][x_index] = '#'
        if j == (time_to_take):
            fh = open('map.txt', 'w')
            for ln in lights_map:
                jln = ''.join(ln)
                fh.write(f"{jln}\n")
            fh.close()

def part_two(input):
    lights = []
    max_x = -1000000
    min_x = 1000000
    max_y = -1000000
    min_y = 1000000
    time_to_take = 0
    i_max_x, i_min_x, i_max_y, i_min_y = 0, 0, 0, 0

    for l in input:
        line = re.sub('=<', '": [', l)
        line = re.sub('> ', '], "', line)
        line = re.sub(r'>$', ']}', line)
        line = '{"' + line
        lights.append(eval(line))

    for i, lgt in enumerate(lights):
        if lgt['position'][0] > max_x:
            max_x = lgt['position'][0]
            i_max_x = i
        if lgt['position'][0] < min_x:
            min_x = lgt['position'][0]
            i_min_x = i
        if lgt['position'][1] > max_y:
            max_y = lgt['position'][1]
            i_max_y = i
        if lgt['position'][0] < min_y:
            min_y = lgt['position'][1]
            i_min_y = i

    x0 = lights[i_max_x]['position'][0]
    x1 = lights[i_min_x]['position'][0]
    y0 = lights[i_max_y]['position'][1]
    y1 = lights[i_min_y]['position'][1]
    box = 1
    while box > 0:
        x0 += lights[i_max_x]['velocity'][0]
        x1 += lights[i_min_x]['velocity'][0]
        y0 += lights[i_max_y]['velocity'][1]
        y1 += lights[i_min_y]['velocity'][1]
        time_to_take += 1
        box = (x0 - x1) * (y0 - y1)
    print(time_to_take)

input_file = open('day-10-input.txt', 'r').read().splitlines()

part_one(input_file) # HRPHBRKG
part_two(input_file) # 10355
