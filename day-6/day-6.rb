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
  point_map = Array.new(400) {Array.new(400, '#')}
  min_x, min_y = [1000, 1000]
  max_x, max_y = [0, 0]
  points = []
  input.each do |pt|
    x, y = pt.split(', ')
    points.push([x.to_i,y.to_i])
  end
  points.each do |x_pt, y_pt|
    min_x = x_pt if min_x > x_pt
    max_x = x_pt if max_x < x_pt
    min_y = y_pt if min_y > y_pt
    max_y = y_pt if max_y < y_pt
  end
  (0..399).each do |y|
    match = true
    (0..399).each do |x|
      mdist = 100000
      name = ''
      points.each do |p|
        distance = (p[0] - x).abs + (p[1] - y).abs
        if distance < mdist
          mdist = distance
          name = points.index(p).to_s
          match = false
        elsif distance == mdist
          match = true
        end
      end
      if not match
        point_map[y][x] = name
      end
    end
  end
  removed_points = []
  (0..399).each do |axis|
    removed_points.append(point_map[0][axis]) if not removed_points.include?(point_map[0][axis])
    removed_points.append(point_map[axis][0]) if not removed_points.include?(point_map[axis][0])
    removed_points.append(point_map[399][axis]) if not removed_points.include?(point_map[399][axis])
    removed_points.append(point_map[axis][399]) if not removed_points.include?(point_map[axis][399])
  end
  pts = Array.new(50, 0)
  (0..399).each do |y|
    (0..399).each do |x|
      if point_map[y][x] != '*' && (not removed_points.include?(point_map[y][x]))
        i = point_map[y][x].to_i
        pts[i] += 1
      end
    end
  end
  top = 0
  pts.each do |v|
    if v > top
      top = v
    end
  end
  puts top
end

def part_two(input)
  point_map = Array.new(400) {Array.new(400, '#')}
  min_x, min_y = [1000, 1000]
  max_x, max_y = [0, 0]
  points = []
  input.each do |pt|
    x, y = pt.split(', ')
    points.push([x.to_i,y.to_i])
  end
  points.each do |x_pt, y_pt|
    min_x = x_pt if min_x > x_pt
    max_x = x_pt if max_x < x_pt
    min_y = y_pt if min_y > y_pt
    max_y = y_pt if max_y < y_pt
  end
  region_area = 0
  (0..399).each do |y|
    match = true
    (0..399).each do |x|
      mdist = 100000
      total_dist = 0
      name = ''
      points.each do |p|
        distance = (p[0] - x).abs + (p[1] - y).abs
        total_dist += distance
        if distance < mdist
          mdist = distance
          name = points.index(p).to_s
          match = false
        elsif distance == mdist
          match = true
        end
      end
      region_area += 1 if total_dist < 10000
      if not match
        point_map[y][x] = name
      end
    end
  end
  removed_points = []
  (0..399).each do |axis|
    removed_points.append(point_map[0][axis]) if not removed_points.include?(point_map[0][axis])
    removed_points.append(point_map[axis][0]) if not removed_points.include?(point_map[axis][0])
    removed_points.append(point_map[399][axis]) if not removed_points.include?(point_map[399][axis])
    removed_points.append(point_map[axis][399]) if not removed_points.include?(point_map[axis][399])
  end
  pts = Array.new(50, 0)
  (0..399).each do |y|
    (0..399).each do |x|
      if point_map[y][x] != '*' && (not removed_points.include?(point_map[y][x]))
        i = point_map[y][x].to_i
        pts[i] += 1
      end
    end
  end
  puts region_area
end

input_file = File.readlines('day-6-input.txt').map(&:chomp)
part_one(input_file) # 4016
part_two(input_file) # 46306
