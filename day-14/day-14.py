#!/usr/bin/env python
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
from collections import defaultdict
# import pprint
import re

# Function definitions

def part_one(input):
    # pp = pprint.PrettyPrinter(indent=4)
    recipes = [3, 7]
    elf_a = 0
    elf_b = 1

    while (len(recipes) < input + 10):
        rcp = recipes[elf_a] + recipes[elf_b]
        if rcp >= 10:
            f,s = list(str(rcp))
            f,s = int(f), int(s)
            recipes.append(f)
            recipes.append(s)
        else:
            recipes.append(rcp)
        elf_a = (recipes[elf_a] + 1 + elf_a) % len(recipes)
        elf_b = (recipes[elf_b] + 1 + elf_b) % len(recipes)
    print(''.join(str(i) for i in recipes[-10:]))

def part_two(input):
    # pp = pprint.PrettyPrinter(indent=4)
    recipes = [3, 7]
    elf_a = 0
    elf_b = 1
    stop = False

    while stop == False:
        rcp = recipes[elf_a] + recipes[elf_b]
        if rcp >= 10:
            f,s = list(str(rcp))
            f,s = int(f), int(s)
            recipes.append(f)
            recipes.append(s)
        else:
            recipes.append(rcp)
        elf_a = (recipes[elf_a] + 1 + elf_a) % len(recipes)
        elf_b = (recipes[elf_b] + 1 + elf_b) % len(recipes)
        if (len(recipes) > 6) and (''.join(str(i) for i in recipes[-6:]) == str(input)):
            print(len(recipes) - 6)
            stop == True

input_no = 919901

# part_one(input_no) # 7861362411
part_two(input_no) # 20203532
