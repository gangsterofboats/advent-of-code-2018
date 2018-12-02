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

# Part One
# 561

# initial_value = 0
# input_file = File.readlines('day-1-input.txt')
# numbers = input_file.map(&:to_i)
# puts numbers.sum

# Part Two
# 563

current_sum = 0
prev_sums = []
input_file = File.readlines('day-1-input.txt')
numbers = input_file.map(&:to_i)
numbers.cycle do |i|
  current_sum = i + current_sum
  if not (prev_sums.include? current_sum)
    prev_sums.push(current_sum)
  else
    puts current_sum
    break
  end
end
