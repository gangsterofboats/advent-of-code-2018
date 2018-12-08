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
  childs, metas = input[0..1]
  input = input[2..-1]
  entries = []
  totals = 0

  childs.downto(1) do
    total, input = part_one(input)
    totals += total
  end
  totals += input[0..metas-1].sum
  return totals, input[metas..-1]
end

def part_two(input)
  childs, metas = input[0..1]
  input = input[2..-1]
  entries = []
  entry = 0

  childs.downto(1) do
    entry, input = part_two(input)
    entries << entry
  end
  if childs == 0
    return input[0..metas-1].sum, input[metas..-1]
  else
    s = 0
    input[0..metas-1].each do |k|
      s += entries[k - 1] if (k <= entries.length)
    end
    return s, input[metas..-1]
  end
end

data = File.readlines('day-8-input.txt')[0].split.map(&:to_i)

total, rest = part_one(data) # 37905
puts total
value, rest = part_two(data) # 33891
puts value
