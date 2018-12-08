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

# Function definition

def part_one(input):
    childs, metas = input[:2]
    input = input[2:]
    meta_sum = 0

    for c in range(childs):
        total, input = part_one(data)
        meta_sum += total
    meta_sum += sum(input[:metas])

    return meta_sum, data[metas:]

def part_two(input):
    childs, metas = input[:2]
    input = input[2:]
    entries = []

    for c in range(childs):
        entry, input = part_two(input)
        entries.append(entry)
    if childs == 0:
        return (sum(input[:metas]), input[metas:])
    else:
        return (
            sum(entries[k - 1] for k in input[:metas] if k > 0 and k <= len(entries)),
            input[metas:]
        )

input_file = open('day-8-input.txt', 'r').read()
data = [int(item) for item in input_file.split()]

total, rest = part_one(data) # 37905
print(total)
value, rest = part_two(data) # 33891
print(value)
