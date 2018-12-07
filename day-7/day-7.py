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
import re
import string
from collections import defaultdict

# Function definitions

def part_one(input):
    s_input = sorted(input)
    letter_pairs_forward = defaultdict(list)
    letter_pairs_backward = defaultdict(list)
    letters = string.ascii_uppercase
    middle = ' must be finished before step '
    for line in s_input:
        aline = re.sub(middle, '=>', line)
        aline = re.sub('Step ', '', aline)
        aline = re.sub(' can begin.', '', aline)
        f,s = aline[0], aline[-1]
        if f not in letter_pairs_forward:
            letter_pairs_forward[f] = [s]
        else:
            letter_pairs_forward[f].append(s)
        if s not in letter_pairs_backward:
            letter_pairs_backward[s] = [f]
        else:
            letter_pairs_backward[s].append(f)
        letter_pairs_forward[f] = sorted(letter_pairs_forward[f])
        letter_pairs_backward[s] = sorted(letter_pairs_backward[s])
    for ltr in letters:
        if ltr not in letter_pairs_forward:
            letter_pairs_forward[ltr] =['']
        if ltr not in letter_pairs_backward:
            letter_pairs_backward[ltr] =['']
    for key in sorted(letter_pairs_backward.keys()):
        print(key, ':', letter_pairs_backward[key])

# def part_two(input):

input_file = open('day-7-input.txt', 'r').read().splitlines()

# Did both parts with pencil and paper mostly
part_one(input_file) # BGKDMJCNEQRSTUZWHYLPAFIVXO
# part_two(input_file) # 941
