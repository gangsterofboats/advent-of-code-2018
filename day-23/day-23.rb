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
  max_radius = 0
  nanobot = 0
  i = 0
  within_range = 0

  input.each do |ln|
    pos, rad = ln.split
    _, rad = rad.split('=').map(&:to_i)
    if rad > max_radius
      max_radius = rad
      nanobot = i
    end
    i += 1
  end
  bot = {'x' => -1, 'y' => -1, 'z' => -1, 'r' => -1}
  bot['x'], bot['y'], bot['z'], bot['r'] = input[nanobot].scan(/-?\d+/).map(&:to_i)
  input.each do |ln|
    f, s = ln.split
    f.gsub!('pos=<', '')
    pos = {'x' => -1, 'y' => -1, 'z' => -1}
    pos['x'], pos['y'], pos['z'] = f[0..-3].split(',').map(&:to_i)
    _, rad = s.split('=').map(&:to_i)
    diff = (pos['x'] - bot['x']).abs + (pos['y'] - bot['y']).abs + (pos['z'] - bot['z']).abs
    if diff < bot['r']
      within_range += 1
    end
  end
  puts within_range
end

def part_two(input)
end

input_file = File.readlines('day-23-input.txt').map(&:chomp)

part_one(input_file) # 652
# part_two(input_file) # not 158395963; too low
