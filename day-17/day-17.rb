#!/usr/bin/env ruby
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

def part_one(input)
  water_spring = [500, 0]
  clay_spots = []
  input.each do |line|
    f, s = line.split(', ')
    f_axis, f_value = f.split('=')
    s_axis, s_range = s.split('=')
    f_value = f_value.to_i
    s_range = eval(s_range).to_a
    s_range.each do |sval|
      if f_axis == 'x'
        clay_spots.push([f_value, sval])
      else
        clay_spots.push([sval, f_value])
      end
    end
  end
  # 429, 684, 7, 1984
  min_x, max_x, min_y, max_y = 100000, -100000, 100000, -100000
  clay_spots.each do |spot|
    if spot[0] < min_x
      min_x = spot[0]
    end
    if spot[0] > max_x
      max_x = spot[0]
    end
    if spot[1] < min_y
      min_y = spot[1]
    end
    if spot[1] > max_y
      max_y = spot[1]
    end
  end
  ground_map = Array.new(2000) {Array.new(700, '.')}
  ground_map[water_spring[1]][water_spring[0]] = '+'
  clay_spots.each do |spt|
    x_pt, y_pt = spt
    ground_map[y_pt][x_pt] = '#'
  end
  gmarr = []
  ground_map.each do |ln|
    wln = ln[400..700]
    gmarr.push(wln.join(''))
    # gmarr.push(ln.join(''))
  end
  IO.write('map.txt', gmarr.join("\n"))
end

def part_two(input)
end

input_file = File.readlines('day-17-input.txt').map(&:chomp)

part_one(input_file) # 29741
# part_two(input_file) # 24198
