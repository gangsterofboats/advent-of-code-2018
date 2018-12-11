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
  fuel_cell_map = Array.new(300) {Array.new(300, 0)}
  (1..300).each do |y_axis|
    (1..300).each do |x_axis|
      rack_ID = x_axis + 10
      power_level = rack_ID * y_axis
      power_level += input
      power_level = power_level * rack_ID
      if power_level >= 100
        power_level = (power_level % 1000) / 100
      else
        power_level = 0
      end
      power_level -= 5
      fuel_cell_map[y_axis - 1][x_axis - 1] = power_level
    end
  end
  max_corner = fuel_cell_map.flatten.max
  max_square = []
  max_power = 0 # 30
  (0..299).each do |y|
    (0..299).each do |x|
      if (fuel_cell_map[y][x] == max_corner) and (x.between?(0,296)) and (y.between?(0,296))
        power = (fuel_cell_map[y][x..x+2]).sum + (fuel_cell_map[y + 1][x..x+2]).sum + (fuel_cell_map[y + 2][x..x+2]).sum
        if max_power < power
          max_power = power
          max_square = [x,y]
        end
      end
    end
  end
  puts "#{max_square[0] + 1},#{max_square[1] + 1}"
end

def part_two(input)
  fuel_cell_map = Array.new(300) {Array.new(300, 0)}
  (1..300).each do |y_axis|
    (1..300).each do |x_axis|
      rack_ID = x_axis + 10
      power_level = rack_ID * y_axis
      power_level += input
      power_level = power_level * rack_ID
      if power_level >= 100
        power_level = (power_level % 1000) / 100
      else
        power_level = 0
      end
      power_level -= 5
      fuel_cell_map[y_axis - 1][x_axis - 1] = power_level
    end
  end
  max_data = [0,0,0,0]
  max_power = 0
  (1..300).each do |sz|
    (0..299).each do |y|
      (0..299).each do |x|
        if (x.between?(0,299 - sz)) and (y.between?(0,299 - sz))
          power = 0
          (y).upto(y+sz) do |y_coord|
            power += fuel_cell_map[y_coord][x..x+sz].sum
          end
          if max_power < power
            max_power = power
            max_data = [x+1,y+1,sz+1,max_power]
            p max_data
          end
        end
      end
    end
  end
end

input_no = 6878

part_one(input_no) # 20,34
part_two(input_no) # 90,57,15
