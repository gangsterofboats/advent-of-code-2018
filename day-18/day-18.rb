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
def check_square(imap, x_pt, y_pt)
  pt_val = imap[y_pt][x_pt]
  if x_pt == 0
    x_range = [0, 1]
  elsif x_pt == 49
    x_range = [48, 49]
  else
    x_range = [x_pt - 1, x_pt, x_pt + 1]
  end

  if y_pt == 0
    y_range = [0, 1]
  elsif y_pt == 49
    y_range = [48, 49]
  else
    y_range = [y_pt - 1, y_pt, y_pt + 1]
  end
  rtn_val = ''
  tree_cnt, yard_cnt = 0, 0

  case pt_val
  when '.'
    y_range.each do |y|
      x_range.each do |x|
        tree_cnt += 1 if imap[y][x] == '|'
      end
    end
    if tree_cnt >= 3
      rtn_val = '|'
    else
      rtn_val = pt_val
    end

  when '|'
    y_range.each do |y|
      x_range.each do |x|
        yard_cnt += 1 if imap[y][x] == '#'
      end
    end
    if yard_cnt >= 3
      rtn_val = '#'
    else
      rtn_val = pt_val
    end

  when '#'
    y_range.each do |y|
      x_range.each do |x|
        tree_cnt += 1 if imap[y][x] == '|'
        yard_cnt += 1 if imap[y][x] == '#'
      end
    end
    if (tree_cnt > 0) and (yard_cnt > 1)
      rtn_val = pt_val
    else
      rtn_val = '.'
    end
  end

  return rtn_val
end

def part_one(input)
  forest_map = input.dup

  10.times do
    next_map = forest_map.dup
    (0..49).each do |y|
      (0..49).each do |x|
        next_map[y][x] = check_square(forest_map, x, y)
      end
    end
    forest_map = next_map
  end
  tree_count, yard_count = 0, 0
  (0..49).each do |y|
    (0..49).each do |x|
      tree_count += 1 if forest_map[y][x] == '|'
      yard_count += 1 if forest_map[y][x] == '#'
    end
  end
  puts (tree_count * yard_count)
end

def part_two(input)
end

input_file = File.readlines('day-18-input.txt').map(&:chomp)

part_one(input_file) # 588436
# part_two(input_file) # 195290
