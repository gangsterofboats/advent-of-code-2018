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

# initial_value = 0
# input_file = open('day-1-input.txt', 'r').read().splitlines()
# numbers = list(map(int, input_file))
# print(sum(numbers))

# Part Two

current_sum = 0
prev_sums = []
input_file = open('day-1-input.txt', 'r').read().splitlines()
numbers = list(map(int, input_file))
for i in itertools.cycle(numbers):
  current_sum = i + current_sum
  if (current_sum not in prev_sums):
    prev_sums.append(current_sum)
  else:
    print(current_sum)
    break
