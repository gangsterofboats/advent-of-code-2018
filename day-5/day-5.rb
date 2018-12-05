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

def part_one(input)
  polymers = input[0].chomp
  letter_pairs = []
  ('a'..'z').each do |ltr|
    letter_pairs.append(ltr + ltr.upcase)
    letter_pairs.append(ltr.upcase + ltr)
  end
  found = true
  loop do
    letter_pairs.each do |pair|
      polymers.gsub!(pair, '')
    end
    found = letter_pairs.any? {|pr| polymers.include? pr}
    break if found == false
  end
  puts polymers.length
end

def part_two(input)
  polymers = input[0].chomp
  letter_pairs = []
  letter_strprs = {}
  ('a'..'z').each do |ltr|
    letter_pairs.append(ltr + ltr.upcase)
    letter_pairs.append(ltr.upcase + ltr)
    letter_strprs[ltr] = polymers.gsub(/#{ltr}|#{ltr.upcase}/, '')
  end
  shortest_chain = 50000
  found = true
  letter_strprs.each do |key, value|
    loop do
      letter_pairs.each do |pair|
        value.gsub!(pair, '')
      end
      found = letter_pairs.any? {|pr| value.include? pr}
      break if found == false
    end
    shortest_chain = value.length if shortest_chain > value.length
  end
  puts shortest_chain
end

input_file = File.readlines('day-5-input.txt')
# part_one(input_file) # 11364
part_two(input_file) # 4212
