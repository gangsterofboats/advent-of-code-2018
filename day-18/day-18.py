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
from copy import deepcopy

# Function definitions
def check_square(imap, x_pt, y_pt):
    pt_val = imap[y_pt][x_pt]
    if x_pt == 0:
        x_range = [0, 1]
    elif x_pt == 49:
        x_range = [48, 49]
    else:
        x_range = list(range(x_pt-1,x_pt+2))

    if y_pt == 0:
        y_range = [0, 1]
    elif y_pt == 49:
        y_range = [48, 49]
    else:
        y_range = list(range(y_pt-1,y_pt+2))
    rtn_val = ''
    tree_cnt, yard_cnt = 0, 0

    if pt_val == '.':
        for y in y_range:
            for x in x_range:
                if (imap[y][x] == '|'):
                    tree_cnt += 1
        if tree_cnt >= 3:
            rtn_val = '|'
        else:
            rtn_val = '.'
    elif pt_val == '|':
        for y in y_range:
            for x in x_range:
                if (imap[y][x] == '#'):
                    yard_cnt += 1
        if yard_cnt >= 3:
            rtn_val = '#'
        else:
            rtn_val = '|'
    elif pt_val == '#':
        for y in y_range:
            for x in x_range:
                if (imap[y][x] == '|'):
                    tree_cnt += 1
                if (imap[y][x] == '#'):
                    yard_cnt += 1
        if (tree_cnt == 0) or (yard_cnt <= 1):
            rtn_val = '.'
        else:
            rtn_val = '#'
    return rtn_val

def part_one(input):
    forest_map = []
    next_map = []

    for ln in input:
        line = list(ln)
        forest_map.append(line)

    for i in range(10):
        next_map = deepcopy(forest_map)
        for y in range(50):
            for x in range(50):
                next_map[y][x] = check_square(forest_map, x, y)
        forest_map = next_map

    tree_count, yard_count = 0, 0
    for y in range(50):
        for x in range(50):
            if forest_map[y][x] == '|':
                tree_count += 1
            if forest_map[y][x] == '#':
                yard_count += 1
    print(tree_count * yard_count)

# def part_two(input)

input_file = open('day-18-input.txt', 'r').read().splitlines()

part_one(input_file) # 588436
# part_two(input_file) # 195290
