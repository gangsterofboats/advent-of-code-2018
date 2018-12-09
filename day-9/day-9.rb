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
  players, num_of_marbs = input.scan(/\d+/).map(&:to_i)
  player_points = [0] * players
  curr_player = 0
  circle = [0]
  cidx = 0

  1.upto(num_of_marbs) do |i|
    if i % 23 == 0
      player_points[curr_player] += i
      player_points[curr_player] += circle.delete_at(cidx - 7)
      cidx -= 7
    else
      if cidx + 2 > circle.length
        circle.insert((cidx + 2) % circle.length, i)
      elsif cidx + 2 == circle.length
        circle.push(i)
      else
        circle.insert(cidx + 2, i)
      end
      cidx = circle.index(i)
    end
    curr_player = (curr_player + 1) % players
  end
  puts player_points.max
end

def part_two(input)
  players, num_of_marbs = input.scan(/\d+/).map(&:to_i)
  num_of_marbs = num_of_marbs * 100
  player_points = [0] * players
  curr_player = 0
  circle = [0]
  cidx = 0

  1.upto(num_of_marbs) do |i|
    if i % 23 == 0
      player_points[curr_player] += i
      player_points[curr_player] += circle.delete_at(cidx - 7)
      cidx -= 7
    else
      if cidx + 2 > circle.length
        circle.insert((cidx + 2) % circle.length, i)
      elsif cidx + 2 == circle.length
        circle.push(i)
      else
        circle.insert(cidx + 2, i)
      end
      cidx = circle.index(i)
    end
    curr_player = (curr_player + 1) % players
  end
  puts player_points.max
end

input_file = File.readlines('day-9-input.txt').map(&:chomp)

part_one(input_file[0]) # 428690
# part_two(input_file[0]) # 3628143500
