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
  lights = []
  max_x = -1000000
  min_x = 1000000
  max_y = -1000000
  min_y = 1000000
  time_to_take = 0
  i_max_x, i_min_x, i_max_y, i_min_y = 0, 0, 0, 0

  input.each do |l|
    line = l.gsub('=<', '=>[')
    line.gsub!('> ', '], :')
    line.gsub!(/>$/, ']}')
    line.prepend('{:')
    lights.push(eval line)
  end
  lights.each_with_index do |lgt, i|
    if lgt[:position][0] > max_x
      max_x = lgt[:position][0]
      i_max_x = i
    end
    if lgt[:position][0] < min_x
      min_x = lgt[:position][0]
      i_min_x = i
    end
    if lgt[:position][1] > max_y
      max_y = lgt[:position][1]
      i_max_y = i
    end
    if lgt[:position][1] < min_y
      min_y = lgt[:position][1]
      i_min_y = i
    end
  end
  x0 = lights[i_max_x][:position][0]
  x1 = lights[i_min_x][:position][0]
  y0 = lights[i_max_y][:position][1]
  y1 = lights[i_min_y][:position][1]
  loop do
    x0 += lights[i_max_x][:velocity][0]
    x1 += lights[i_min_x][:velocity][0]
    y0 += lights[i_max_y][:velocity][1]
    y1 += lights[i_min_y][:velocity][1]
    time_to_take += 1
    break if (x1 + 100) > x0
  end
  1.upto(10357) do |j|
    lights_map = Array.new(200) {Array.new(300, '.')} if j > 10352
    lights.each do |light|
      light[:position][0] += light[:velocity][0]
      light[:position][1] += light[:velocity][1]
      x_index = light[:position][0]
      y_index = light[:position][1]
      lights_map[y_index][x_index] = '#' if j > 10352
    end
    if j > 10352
      parr = []
      lights_map.each do |ln|
        parr.push(ln.join(''))
      end
      IO.write("map-#{j}.txt", parr.join("\n"))
    end
  end
end

# def part_two(input)
# end

input_file = File.readlines('day-10-input.txt').map(&:chomp)

# Hand iterated for part two

part_one(input_file) # HRPHBRKG
# part_two(input_file) # 10355
