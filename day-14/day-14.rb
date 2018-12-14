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
  recipes = [3, 7]
  elf_a = 0
  elf_b = 1

  while recipes.length < input + 10
    rcp = recipes[elf_a] + recipes[elf_b]
    if rcp >= 10
      f,s = rcp.to_s.split(//)
      f,s = f.to_i, s.to_i
      recipes.append(f)
      recipes.append(s)
    else
      recipes.append(rcp)
    end
    elf_a = (recipes[elf_a] + 1 + elf_a) % recipes.length
    elf_b = (recipes[elf_b] + 1 + elf_b) % recipes.length
  end
  puts recipes[-10..-1].join('')
end

def part_two(input)
  recipes = [3, 7]
  elf_a = 0
  elf_b = 1
  stop = false

  while stop == false
    rcp = recipes[elf_a] + recipes[elf_b]
    if rcp >= 10
      f,s = rcp.to_s.split(//)
      f,s = f.to_i, s.to_i
      recipes.append(f)
      recipes.append(s)
    else
      recipes.append(rcp)
    end
    elf_a = (recipes[elf_a] + 1 + elf_a) % recipes.length
    elf_b = (recipes[elf_b] + 1 + elf_b) % recipes.length

    if (recipes.length > 6) and (recipes[-6..-1].join('') == input.to_s)
      stop = true
    end
  end
  puts recipes.length - 6
end

input_no = 919901

# part_one(input_no) # 7861362411
part_two(input_no) # 20203532
