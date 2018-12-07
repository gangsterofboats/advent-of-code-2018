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
  s_input = input.sort
  letter_pairs_forward = {}
  letter_pairs_backward = {}
  letters = ('A'..'Z').to_a
  middle = ' must be finished before step '
  s_input.each do |line|
    aline = line.gsub(middle, '=>')
    aline = aline.gsub('Step ', '')
    aline = aline.gsub(' can begin.', '')
    f, s = aline[0], aline[-1]
    if not letter_pairs_forward.key?(f)
      letter_pairs_forward[f] = [s]
    else
      letter_pairs_forward[f].push(s)
    end
    if not letter_pairs_backward.key?(s)
      letter_pairs_backward[s] = [f]
    else
      letter_pairs_backward[s].push(f)
    end
  end
  letters.each do |ltr|
    if not letter_pairs_forward.key?(ltr)
      letter_pairs_forward[ltr] = ['']
    end
    if not letter_pairs_backward.key?(ltr)
      letter_pairs_backward[ltr] = ['']
    end
  end
  puts letter_pairs_backward.sort.to_h
end

def part_two(input)
end

input_file = File.readlines('day-7-input.txt').map(&:chomp)

# Did both parts with pencil and paper mostly
part_one(input_file) # BGKDMJCNEQRSTUZWHYLPAFIVXO
# part_two(input_file) # 941
