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
from collections import deque
import re

# Function definitions

def part_one(input):
    players, num_of_marbs = map(int, re.findall(r'\d+', input))
    player_points = [0] * players
    curr_player = 0
    circle = [0]
    cidx = 0

    for i in range(1, num_of_marbs + 1):
        if i % 23 == 0:
            player_points[curr_player] += i
            player_points[curr_player] += circle.pop(cidx - 7)
            cidx -= 7
        else:
            if cidx + 2 > len(circle):
                circle.insert((cidx + 2) % len(circle), i)
            elif cidx + 2 == len(circle):
                circle.append(i)
            else:
                circle.insert(cidx + 2, i)
            cidx = circle.index(i)
        curr_player = (curr_player + 1) % players
    print(max(player_points))

def part_two(input):
    players, num_of_marbs = map(int, re.findall(r'\d+', input))
    num_of_marbs = num_of_marbs * 100
    player_points = [0] * players
    curr_player = 0
    circle = deque([0])

    for i in range(1, num_of_marbs + 1):
        if i % 23 == 0:
            player_points[curr_player] += i
            circle.rotate(7)
            player_points[curr_player] += circle.pop()
            circle.rotate(-1)
        else:
            circle.rotate(-1)
            circle.append(i)
        curr_player = (curr_player + 1) % players
    print(max(player_points))

input_file = open('day-9-input.txt', 'r').read()

part_one(input_file) # 428690
part_two(input_file) # 3628143500
