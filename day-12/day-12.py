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
    initial_state = input[0]
    initial_state = re.sub('^.*: ', '', initial_state)
    rules = {}

    for line in range(2,len(input)):
        k,v = input[line].split(' => ')
        rules[k] = v

    gen = defaultdict(lambda: '.')
    for p in range(len(initial_state)):
        gen[p] = initial_state[p]

    # pp.pprint(gen)

    for _ in range(20):
        next_gen = defaultdict(lambda: '.')
        min_pot = min(gen.keys()) - 2
        max_pot = max(gen.keys()) + 3
        for pot in range(min_pot, max_pot + 1):
            plant_state = ''
            for s in range(pot - 2, pot + 3):
                plant_state += gen[s]
            next_gen[pot] = rules[plant_state]
        gen = next_gen

    sum = 0
    for key,value in gen.items():
        if value == '#':
            sum += key
    print(sum)

def part_two(input):
    # pp = pprint.PrettyPrinter(indent=4)
    initial_state = input[0]
    initial_state = re.sub('^.*: ', '', initial_state)
    rules = {}

    for line in range(2,len(input)):
        k,v = input[line].split(' => ')
        rules[k] = v

    gen = defaultdict(lambda: '.')
    for p in range(len(initial_state)):
        gen[p] = initial_state[p]

    # pp.pprint(gen)

    for _ in range(50000000000):
        next_gen = defaultdict(lambda: '.')
        min_pot = min(gen.keys()) - 2
        max_pot = max(gen.keys()) + 3
        for pot in range(min_pot, max_pot + 1):
            plant_state = ''
            for s in range(pot - 2, pot + 3):
                plant_state += gen[s]
            next_gen[pot] = rules[plant_state]
        gen = next_gen

    sum = 0
    for key,value in gen.items():
        if value == '#':
            sum += key
    print(sum)


input_file = open('day-12-input.txt', 'r').read().splitlines()

part_one(input_file) # 3405
# part_two(input_file) # 3350000000000
