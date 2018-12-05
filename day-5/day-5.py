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

def part_one(input):
    polymers = input
    letter_pairs = []
    for ltr in zip(string.ascii_lowercase, string.ascii_uppercase):
        letter_pairs.append(ltr[1] + ltr[0])
        letter_pairs.append(ltr[0] + ltr[1])
    found = True
    while found:
        for pair in letter_pairs:
            polymers = re.sub(pair, '', polymers)
        if not any(pr in polymers for pr in letter_pairs):
            found = False
    print(len(polymers))

def part_two(input):
    polymers = input
    letter_pairs = []
    letter_strprs = {}
    for ltr in zip(string.ascii_lowercase, string.ascii_uppercase):
        letter_pairs.append(ltr[1] + ltr[0])
        letter_pairs.append(ltr[0] + ltr[1])
        pattern = ltr[0] + r'|' + ltr[1]
        letter_strprs[ltr[0]] = re.sub(pattern, '', polymers)
    shortest_chain = 50000
    for value in letter_strprs.values():
        found = True
        while found:
            for pair in letter_pairs:
                value = re.sub(pair, '', value)
            if not any(pr in value for pr in letter_pairs):
                found = False
        if shortest_chain > len(value):
            shortest_chain = len(value)
    print(shortest_chain)

input_file = open('day-5-input.txt', 'r').read().rstrip()
# part_one(input_file) # 11364
part_two(input_file) # 4212
