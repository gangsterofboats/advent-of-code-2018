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
import collections

# Function definitions

def addr(bfr, nos):
    a, b, c = nos
    ipt = bfr.copy()
    ipt[c] = ipt[a] + ipt[b]
    return ipt

def addi(bfr, nos):
    a, b, c = nos
    ipt = bfr.copy()
    ipt[c] = ipt[a] + b
    return ipt

def mulr(bfr, nos):
    a, b, c = nos
    ipt = bfr.copy()
    ipt[c] = ipt[a] * ipt[b]
    return ipt

def muli(bfr, nos):
    a, b, c = nos
    ipt = bfr.copy()
    ipt[c] = ipt[a] * b
    return ipt

def banr(bfr, nos):
    a, b, c = nos
    ipt = bfr.copy()
    ipt[c] = ipt[a] & ipt[b]
    return ipt

def bani(bfr, nos):
    a, b, c = nos
    ipt = bfr.copy()
    ipt[c] = ipt[a] & b
    return ipt

def borr(bfr, nos):
    a, b, c = nos
    ipt = bfr.copy()
    ipt[c] = ipt[a] | ipt[b]
    return ipt

def bori(bfr, nos):
    a, b, c = nos
    ipt = bfr.copy()
    ipt[c] = ipt[a] | b
    return ipt

def setr(bfr, nos):
    a, b, c = nos
    ipt = bfr.copy()
    ipt[c] = ipt[a]
    return ipt

def seti(bfr, nos):
    a, b, c = nos
    ipt = bfr.copy()
    ipt[c] = a
    return ipt

def gtir(bfr, nos):
    a, b, c = nos
    ipt = bfr.copy()
    if (a > ipt[b]):
        ipt[c] = 1
    else:
        ipt[c] = 0
    return ipt

def gtri(bfr, nos):
    a, b, c = nos
    ipt = bfr.copy()
    if (ipt[a] > b):
        ipt[c] = 1
    else:
        ipt[c] = 0
    return ipt

def gtrr(bfr, nos):
    a, b, c = nos
    ipt = bfr.copy()
    if (ipt[a] > ipt[b]):
        ipt[c] = 1
    else:
        ipt[c] = 0
    return ipt

def eqir(bfr, nos):
    a, b, c = nos
    ipt = bfr.copy()
    if (a == ipt[b]):
        ipt[c] = 1
    else:
        ipt[c] = 0
    return ipt

def eqri(bfr, nos):
    a, b, c = nos
    ipt = bfr.copy()
    if (ipt[a] == b):
        ipt[c] = 1
    else:
        ipt[c] = 0
    return ipt

def eqrr(bfr, nos):
    a, b, c = nos
    ipt = bfr.copy()
    if (ipt[a] == ipt[b]):
        ipt[c] = 1
    else:
        ipt[c] = 0
    return ipt

def part_one(input):
    ops = {'addr': addr, 'addi': addi, 'mulr': mulr, 'muli': muli, 'banr': banr, 'bani': bani, 'borr': borr,
           'bori': bori, 'setr': setr, 'seti': seti, 'gtir': gtir, 'gtri': gtri, 'gtrr': gtrr, 'eqir': eqir,
           'eqri': eqri, 'eqrr': eqrr}
    _, bound_point = input[0].split()
    bound_point = int(bound_point)
    instruct_point = 0
    actions = []
    registers = [0, 0, 0, 0, 0, 0]

    for ln in range(1, len(input)):
        opcode, a, b, c = input[ln].split()
        a, b, c = int(a), int(b), int(c)
        actions.append([opcode, a, b, c])

    while instruct_point <= len(actions):
        actn = actions[instruct_point]
        registers[bound_point] = instruct_point
        registers = ops[actn[0]](registers, actn[1:])
        instruct_point = registers[bound_point] + 1

    print(registers[0])

def part_two(input):
    ops = {'addr': addr, 'addi': addi, 'mulr': mulr, 'muli': muli, 'banr': banr, 'bani': bani, 'borr': borr,
           'bori': bori, 'setr': setr, 'seti': seti, 'gtir': gtir, 'gtri': gtri, 'gtrr': gtrr, 'eqir': eqir,
           'eqri': eqri, 'eqrr': eqrr}
    _, bound_point = input[0].split()
    bound_point = int(bound_point)
    instruct_point = 0
    actions = []
    registers = [1, 0, 0, 0, 0, 0]

    for ln in range(1, len(input)):
        opcode, a, b, c = input[ln].split()
        a, b, c = int(a), int(b), int(c)
        actions.append([opcode, a, b, c])

    while instruct_point <= len(actions):
        actn = actions[instruct_point]
        registers[bound_point] = instruct_point
        registers = ops[actn[0]](registers, actn[1:])
        instruct_point = registers[bound_point] + 1

    print(registers[0])

input_file = open('day-19-input.txt', 'r').read().splitlines()

part_one(input_file) # 1140
part_two(input_file) # 12474720
