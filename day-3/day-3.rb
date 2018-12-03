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
# 121163

# claims = File.readlines('day-3-input.txt')
# fabric_map = Array.new(1000) {Array.new(1000, 0)}
# claim_dims = {:x_offset => 0, :y_offset => 0, :wide => 0, :tall => 0}
# claims.each do |claim|
  # xy = claim.scan(/\d+,\d+/)[0]
  # wt = claim.scan(/\d+x\d+/)[0]
  # claim_dims[:x_offset] = xy.split(',')[0].to_i
  # claim_dims[:y_offset] = xy.split(',')[1].to_i
  # claim_dims[:wide] = wt.split('x')[0].to_i
  # claim_dims[:tall] = wt.split('x')[1].to_i
  # 0.upto(claim_dims[:tall] - 1) do |hindex|
    # 0.upto(claim_dims[:wide] - 1) do |windex|
      # fabric_map[claim_dims[:y_offset] + hindex - 1][claim_dims[:x_offset] + windex - 1] += 1
    # end
  # end
# end
# puts fabric_map.flatten.count {|x| x >= 2}

# Part 2
# 943

input_file = File.readlines('day-3-input.txt')
claims = {}
ids = []
fabric_map = Array.new(1000) {Array.new(1000, 0)}
input_file.each do |line|
  id = line.scan(/#\d+/)[0][1..-1].to_i
  xy = line.scan(/\d+,\d+/)[0]
  wt = line.scan(/\d+x\d+/)[0]
  x_offset = xy.split(',')[0].to_i
  y_offset = xy.split(',')[1].to_i
  width = wt.split('x')[0].to_i
  height = wt.split('x')[1].to_i
  ids.push(id)
  claims[id] = [x_offset, y_offset, width, height]
  0.upto(height - 1) do |hindex|
    0.upto(width - 1) do |windex|
      fabric_map[y_offset + hindex - 1][x_offset + windex - 1] += 1
    end
  end
end
claims.each do |k,v|
  x_offset = v[0]
  y_offset = v[1]
  width = v[2]
  height = v[3]
  0.upto(height - 1) do |hindex|
    0.upto(width - 1) do |windex|
      ids.delete(k) if fabric_map[y_offset + hindex - 1][x_offset + windex - 1] > 1
    end
  end
end
puts ids
