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
  arrow_input = []
  letter_pairs_forward = {}
  letter_pairs_backward = {}
  letters = ('A'..'Z').to_a
  middle = ' must be finished before step '
  input.each do |line|
    aline = line.gsub(middle, '=>')
    aline = aline.gsub('Step ', '')
    aline = aline.gsub(' can begin.', '')
    arrow_input.push(aline)
  end
  arrow_input.sort!
  letters.each do |ltr|
    paired_letters_forward = []
    arrow_input.each do |arw|
      if arw.start_with?(ltr)
        paired_letters_forward.push(arw[-1])
      end
    end
    letter_pairs_forward[ltr] = paired_letters_forward
  end
  letters.each do |ltr|
    paired_letters_backward = []
    arrow_input.each do |arw|
      wra = arw.reverse
      if wra.start_with?(ltr)
        paired_letters_backward.push(wra[-1])
      end
    end
    letter_pairs_backward[ltr] = paired_letters_backward
  end
  puts letter_pairs_backward
end

def part_two(input)
end

input_file = File.readlines('day-7-input.txt').map(&:chomp)

# Did both parts with pencil and paper mostly
part_one(input_file) # BGKDMJCNEQRSTUZWHYLPAFIVXO
# part_two(input_file) # 941
