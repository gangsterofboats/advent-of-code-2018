#!/usr/bin/env ruby
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
# Function definitions

def exec_opcodes(code, bfr, nos)
  # addr addi mulr muli banr bani borr bori setr seti gtir gtri gtrr eqir eqri eqrr']
  ipt = bfr.dup
  _, a, b, c = nos

  case code
  when 'addr'
    ipt[c] = ipt[a] + ipt[b]
  when 'addi'
    ipt[c] = ipt[a] + b
  when 'mulr'
    ipt[c] = ipt[a] * ipt[b]
  when 'muli'
    ipt[c] = ipt[a] * b
  when 'banr'
    ipt[c] = ipt[a] & ipt[b]
  when 'bani'
    ipt[c] = ipt[a] & b
  when 'borr'
    ipt[c] = ipt[a] | ipt[b]
  when 'bori'
    ipt[c] = ipt[a] | b
  when 'setr'
    ipt[c] = ipt[a]
  when 'seti'
    ipt[c] = a
  when 'gtir'
    if a > ipt[b]
      ipt[c] = 1
    else
      ipt[c] = 0
    end
  when 'gtri'
    if ipt[a] > b
      ipt[c] = 1
    else
      ipt[c] = 0
    end
  when 'gtrr'
    if ipt[a] > ipt[b]
      ipt[c] = 1
    else
      ipt[c] = 0
    end
  when 'eqir'
    if a == ipt[b]
      ipt[c] = 1
    else
      ipt[c] = 0
    end
  when 'eqri'
    if ipt[a] == b
      ipt[c] = 1
    else
      ipt[c] = 0
    end
  when 'eqrr'
    if ipt[a] == ipt[b]
      ipt[c] = 1
    else
      ipt[c] = 0
    end
  end

  return ipt
end

def test_opcodes(inarr, instruct, outarr)
  opcs = ['addr', 'addi', 'mulr', 'muli', 'banr', 'bani', 'borr', 'bori', 'setr', 'seti', 'gtir', 'gtri', 'gtrr', 'eqir', 'eqri', 'eqrr']
  matches = 0

  opcs.each do |c|
    rarr = exec_opcodes(c, inarr, instruct)
    if outarr == rarr
      matches += 1
    end
  end

  return matches
end

def find_opcodes(ina, inst, outa)
  opcs = ['addr', 'addi', 'mulr', 'muli', 'banr', 'bani', 'borr', 'bori', 'setr', 'seti', 'gtir', 'gtri', 'gtrr', 'eqir', 'eqri', 'eqrr']
  poss_opcs = []

  opcs.each do |cde|
    reta = exec_opcodes(cde, ina, inst)
    if outa == reta
      poss_opcs << cde
    end
  end
  return poss_opcs
end

def part_one(input)
  three_ops = 0
  samples = []
  mtch = []

  input.each_slice(3) do |b,n,a|
    samples.push([b,n,a])
  end
  samples.each do |arr|
    _, bef = arr[0].split(': ')
    ints = arr[1].split(' ').map(&:to_i)
    _, aft = arr[2].split(':  ')
    bef = eval bef
    aft = eval aft
    mtch = test_opcodes(bef, ints, aft)
    three_ops += 1 if mtch >= 3
  end
  puts three_ops
end

def part_two(tests, input)
  samples = []
  poss = Hash.new { |h,k| h[k] = [] }
  opcodes = {}
  registers = [0, 0, 0, 0]

  # Find opcodes
  tests.each_slice(3) do |b,n,a|
    _, bef = b.split(': ')
    ints = n.split(' ').map(&:to_i)
    _, aft = a.split(':  ')
    bef = eval bef
    aft = eval aft
    samples.push([bef, ints, aft])
  end
  samples.each do |samp|
    res = find_opcodes(samp[0], samp[1], samp[2])
    poss[samp[1][0]] += res
    poss[samp[1][0]] = poss[samp[1][0]].uniq
  end
  while poss.length > 0
    poss.each do |key,value|
      if value.length == 1
        opcodes[key] = value[0]
        poss.delete(key)
        poss.each do |k,v|
          if poss[k].include? value[0]
            poss[k].delete(value[0])
          end
        end
      end
    end
  end

  # Finally start part 2
  input.each do |ln|
    opno, a, b, c = ln.split.map(&:to_i)
    ns = [opno, a, b, c]
    registers = exec_opcodes(opcodes[opno], registers, ns)
  end
  puts registers[0]
end

# Manually split and cleaned up the input file
test_cases = File.readlines('day-16-input-p1.txt').map(&:chomp)
input_file = File.readlines('day-16-input-p2.txt').map(&:chomp)

part_one(test_cases) # 542
part_two(test_cases, input_file) # 575
