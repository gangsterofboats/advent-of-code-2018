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
import numpy

# Function definitions

def part_one(input):
    fuel_cell_map = numpy.zeros((300,300), dtype=int)
    for y_axis in range(1,301):
        for x_axis in range(1,301):
            rack_ID = x_axis + 10
            power_level = rack_ID * y_axis
            power_level += input
            power_level = power_level * rack_ID
            if power_level >= 100:
                power_level = (power_level % 1000) // 100
            else:
                power_level = 0
            power_level -= 5
            fuel_cell_map[y_axis - 1, x_axis - 1] = power_level
    max_corner = numpy.amax(fuel_cell_map.flatten())
    max_square = []
    max_power = 0 # 30
    for y in range(300):
        for x in range(300):
            if (fuel_cell_map[y, x] == max_corner) and (0 <= x <= 297) and (0 <= y <= 297):
                power = numpy.sum(fuel_cell_map[y, x:x+3:1]) + numpy.sum(fuel_cell_map[y + 1, x:x+3:1]) + numpy.sum(fuel_cell_map[y + 2, x:x+3:1])
                if max_power < power:
                    max_power = power
                    max_square = [x,y]
    print(f"{max_square[0] + 1},{max_square[1] + 1}")

def part_two(input):
    fuel_cell_map = numpy.zeros((300,300), dtype=int)
    for y_axis in range(1,301):
        for x_axis in range(1,301):
            rack_ID = x_axis + 10
            power_level = rack_ID * y_axis
            power_level += input
            power_level = power_level * rack_ID
            if power_level >= 100:
                power_level = (power_level % 1000) // 100
            else:
                power_level = 0
            power_level -= 5
            fuel_cell_map[y_axis - 1, x_axis - 1] = power_level
    max_square = []
    max_power = 0 # 30
    for sz in range(1,301):
        for y in range(300):
            for x in range(300):
                if (0 <= x <= 299-sz) and (0 <= y <= 299-sz):
                    power = 0
                    for y_coord in range(y,y+sz+1):
                        power += numpy.sum(fuel_cell_map[y_coord, x:x+sz+1:1])
                    if max_power < power:
                        max_power = power
                        max_square = [x,y,sz]
                        print(f"{max_square[0] + 1},{max_square[1] + 1},{max_square[2] + 1}")

input_no = 6878

part_one(input_no) # 20,34
part_two(input_no) # 90,57,15
