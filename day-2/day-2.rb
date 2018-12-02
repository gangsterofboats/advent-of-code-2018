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

# box_ids = File.readlines('day-2-input.txt').map(&:chomp)
# box_ids_freq = Hash.new
# checksum = {:twice => 0, :thrice => 0}
# box_ids.each do |id|
  # char_count = Hash.new(0)
  # id.each_char {|c| char_count[c] += 1}
  # box_ids_freq[id] = char_count
# end
# box_ids_freq.each do |key, value|
  # checksum[:twice] += 1  if value.any? {|k,v| v == 2}
  # checksum[:thrice] += 1 if value.any? {|k,v| v == 3}
# end
# puts checksum[:twice] * checksum[:thrice]

# Part Two

box_ids = File.readlines('day-2-input.txt').map(&:chomp)
box_ids.combination(2).each do |i, j|
  zipped_ids = i.chars.zip(j.chars)
  errors = 0
  zip_id = ''
  zipped_ids.each do |f, s|
    zip_id += f if f == s
  end
  puts zip_id if zip_id.length == 25
end
