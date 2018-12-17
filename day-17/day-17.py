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
import re

# Function definitions

def part_one(input):
    water_spring = [500, 0]
    clay_spots = []
    for line in input:
        f, s = line.split(', ')
        f_axis, f_value = f.split('=')
        s_axis, s_range = s.split('=')
        f_value = int(f_value)
        s_start, s_end = s_range.split('..')
        s_range = list(range(int(s_start), int(s_end) + 1))
        for sval in s_range:
            if f_axis == 'x':
                clay_spots.append([f_value, sval])
            else:
                clay_spots.append([sval, f_value])
    # 429, 684, 7, 1984
    min_x, max_x, min_y, max_y = 100000, -100000, 100000, -100000
    for spot in clay_spots:
        if spot[0] < min_x:
            min_x = spot[0]
        if spot[0] > max_x:
            max_x = spot[0]
        if spot[1] < min_y:
            min_y = spot[1]
        if spot[1] > max_y:
            max_y = spot[1]
    ground_map = []
    for _ in range(2001):
        ground_map.append(['.'] * 700)
    ground_map[water_spring[1]][water_spring[0]] = '+'
    for spt in clay_spots:
        x_pt, y_pt = spt
        ground_map[y_pt][x_pt] = '#'
    gmarr = []
    fh = open('map.txt', 'w')
    for ln in ground_map:
        wln = ''.join(ln[400:701])
        fh.write("%s\n" % wln)
    fh.close()

# def part_two(input):

input_file = open('day-17-input.txt', 'r').read().splitlines()

part_one(input_file) #
# part_two(input_file) #
