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
import numpy
import re

# Part One
# 121163

# claims = open('day-3-input.txt', 'r').read().splitlines()
# fabric_map = numpy.zeros((1000, 1000))
# for claim in claims:
    # pattern = re.compile('\d+')
    # result = pattern.findall(claim)
    # (claim_id, x_offset, y_offset, wide, tall) = (int(result[0]), int(result[1]), int(result[2]), int(result[3]), int(result[4]))
    # for hindex in range(y_offset, y_offset + tall):
        # for windex in range(x_offset, x_offset + wide):
            # fabric_map[hindex, windex] += 1
# overlap = 0
# for sq in fabric_map.flatten():
    # if sq >= 2.0:
        # overlap += 1

# print(overlap)

# Part Two
# 943

input_file = open('day-3-input.txt', 'r').read().splitlines()
claims = {}
ids = []
fabric_map = numpy.zeros((1500, 1500))
for line in input_file:
    pattern = re.compile('\d+')
    result = pattern.findall(line)
    (claim_id, x_offset, y_offset, wide, tall) = (int(result[0]), int(result[1]), int(result[2]), int(result[3]), int(result[4]))
    ids.append(claim_id)
    claims[claim_id] = [x_offset, y_offset, wide, tall]
    for hindex in range(y_offset, y_offset + tall):
        for windex in range(x_offset, x_offset + wide):
            fabric_map[hindex, windex] += 1

for k,v in claims.items():
    x_offset = v[0]
    y_offset = v[1]
    wide = v[2]
    tall = v[3]
    for hindex in range(y_offset, y_offset + tall):
        for windex in range(x_offset, x_offset + wide):
            if fabric_map[hindex, windex] > 1:
                try:
                    ids.remove(k)
                except:
                    next
print(ids)
