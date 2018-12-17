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
    _, a, b, c = nos
    ipt = bfr.copy()
    ipt[c] = ipt[a] + ipt[b]
    return ipt

def addi(bfr, nos):
    _, a, b, c = nos
    ipt = bfr.copy()
    ipt[c] = ipt[a] + b
    return ipt

def mulr(bfr, nos):
    _, a, b, c = nos
    ipt = bfr.copy()
    ipt[c] = ipt[a] * ipt[b]
    return ipt

def muli(bfr, nos):
    _, a, b, c = nos
    ipt = bfr.copy()
    ipt[c] = ipt[a] * b
    return ipt

def banr(bfr, nos):
    _, a, b, c = nos
    ipt = bfr.copy()
    ipt[c] = ipt[a] & ipt[b]
    return ipt

def bani(bfr, nos):
    _, a, b, c = nos
    ipt = bfr.copy()
    ipt[c] = ipt[a] & b
    return ipt

def borr(bfr, nos):
    _, a, b, c = nos
    ipt = bfr.copy()
    ipt[c] = ipt[a] | ipt[b]
    return ipt

def bori(bfr, nos):
    _, a, b, c = nos
    ipt = bfr.copy()
    ipt[c] = ipt[a] | b
    return ipt

def setr(bfr, nos):
    _, a, b, c = nos
    ipt = bfr.copy()
    ipt[c] = ipt[a]
    return ipt

def seti(bfr, nos):
    _, a, b, c = nos
    ipt = bfr.copy()
    ipt[c] = a
    return ipt

def gtir(bfr, nos):
    _, a, b, c = nos
    ipt = bfr.copy()
    if (a > ipt[b]):
        ipt[c] = 1
    else:
        ipt[c] = 0
    return ipt

def gtri(bfr, nos):
    _, a, b, c = nos
    ipt = bfr.copy()
    if (ipt[a] > b):
        ipt[c] = 1
    else:
        ipt[c] = 0
    return ipt

def gtrr(bfr, nos):
    _, a, b, c = nos
    ipt = bfr.copy()
    if (ipt[a] > ipt[b]):
        ipt[c] = 1
    else:
        ipt[c] = 0
    return ipt

def eqir(bfr, nos):
    _, a, b, c = nos
    ipt = bfr.copy()
    if (a == ipt[b]):
        ipt[c] = 1
    else:
        ipt[c] = 0
    return ipt

def eqri(bfr, nos):
    _, a, b, c = nos
    ipt = bfr.copy()
    if (ipt[a] == b):
        ipt[c] = 1
    else:
        ipt[c] = 0
    return ipt

def eqrr(bfr, nos):
    _, a, b, c = nos
    ipt = bfr.copy()
    if (ipt[a] == ipt[b]):
        ipt[c] = 1
    else:
        ipt[c] = 0
    return ipt

def test_opcodes(inarr, instruct, outarr):
    ops = [addr, addi, mulr, muli, banr, bani, borr, bori, setr, seti, gtir, gtri, gtrr, eqir, eqri, eqrr]
    matches = 0

    for op in ops:
        rarr = op(inarr, instruct)
        if (outarr == rarr):
            matches += 1
    return matches

def find_opcodes(ina, inst, outa):
    ops = [addr, addi, mulr, muli, banr, bani, borr, bori, setr, seti, gtir, gtri, gtrr, eqir, eqri, eqrr]
    poss_ops = []

    for op in ops:
        reta = op(ina, inst)
        if (outa == reta):
            poss_ops.append(op)
    return poss_ops

def grouper(iterable, n, fillvalue=None):
    "Collect data into fixed-length chunks or blocks"
    args = [iter(iterable)] * n
    return itertools.zip_longest(*args, fillvalue=fillvalue)

def part_one(input):
    three_ops = 0
    samples = []
    mtch = -1

    for g in grouper(input, 3):
        b, n, a = g
        _, bef = b.split(': ')
        ints = list(map(int, n.split()))
        _, aft = a.split(':  ')
        bef = eval(bef)
        aft = eval(aft)
        mtch = test_opcodes(bef, ints, aft)
        if mtch >= 3:
            three_ops += 1
    print(three_ops)

def part_two(tests, input):
    samples = []
    poss = collections.defaultdict(list)
    opcodes = {}
    registers = [0, 0, 0, 0]

    # Find opcodes
    for g in grouper(tests, 3):
        b, n, a = g
        tst = b.split(': ')
        _, bef = b.split(': ')
        ints = list(map(int, n.split()))
        _, aft = a.split(':  ')
        bef = eval(bef)
        aft = eval(aft)
        samples.append([bef, ints, aft])

    for samp in samples:
        res = find_opcodes(samp[0], samp[1], samp[2])
        poss[samp[1][0]] += res
        poss[samp[1][0]] = list(dict.fromkeys(poss[samp[1][0]]))

    while len(poss) > 0:
        for key, value in poss.copy().items():
            if len(value) == 1:
                opcodes[key] = value[0]
                poss.pop(key)
                for k, v in poss.items():
                    if value[0] in poss[k]:
                        poss[k].remove(value[0])

    # Finally start part 2
    for ln in input:
        opno, a, b, c = list(map(int, ln.split()))
        ns = [opno, a, b, c]
        registers = opcodes[opno](registers, ns)
    print(registers[0])

# Manually split and cleaned up the input file
test_cases = open('day-16-input-p1.txt', 'r').read().splitlines()
input_file = open('day-16-input-p2.txt', 'r').read().splitlines()

part_one(test_cases) # 542
part_two(test_cases, input_file) # 575
