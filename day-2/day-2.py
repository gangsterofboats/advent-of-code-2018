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

import itertools
# Part One
# 248 * 23 = 5704

# box_ids = open('day-2-input.txt', 'r').read().splitlines()
# box_ids_freq = {}
# checksum = {'twice': 0, 'thrice': 0}
# for box in box_ids:
    # char_count = dict.fromkeys(box, 0)
    # for c in box:
        # char_count[c] += 1
    # box_ids_freq[box] = char_count
# for v in box_ids_freq.values():
    # if any(value == 2 for value in v.values()):
        # checksum['twice'] += 1
    # if any(value == 3 for value in v.values()):
        # checksum['thrice'] += 1
# print(checksum['twice'] * checksum['thrice'])


# Part Two
# umdryabviapkozistwcnihjqx

box_ids = open('day-2-input.txt', 'r').read().splitlines()
for i, j in itertools.combinations(box_ids, 2):
    zipped_ids = zip(i,j)
    zip_id = ''
    for f, s in zipped_ids:
        if f == s:
            zip_id += f
    if len(zip_id) == 25:
        print(zip_id)
