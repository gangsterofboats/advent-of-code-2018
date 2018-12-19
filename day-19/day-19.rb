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

def exec_opcodes(code, rgstrs, nos)
  ipt = rgstrs.dup
  a, b, c = nos

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

def part_one(input)
  _, bound_point = input[0].split
  bound_point = bound_point.to_i
  instruct_point = 0
  actions = []
  registers = [0, 0, 0, 0, 0, 0]

  input[1..-1].each do |ln|
    opcode, a, b, c = ln.split
    a, b, c = a.to_i, b.to_i, c.to_i
    actions.push([opcode, a, b, c])
  end

  while instruct_point <= actions.length
    actn = actions[instruct_point]
    registers[bound_point] = instruct_point
    registers = exec_opcodes(actn[0], registers, actn[1..-1])
    instruct_point = registers[bound_point] + 1
  end
  puts registers[0]
end

def part_two(input)
  _, bound_point = input[0].split
  bound_point = bound_point.to_i
  instruct_point = 0
  actions = []
  registers = [1, 0, 0, 0, 0, 0]

  input[1..-1].each do |ln|
    opcode, a, b, c = ln.split
    a, b, c = a.to_i, b.to_i, c.to_i
    actions.push([opcode, a, b, c])
  end

  while instruct_point <= actions.length
    actn = actions[instruct_point]
    registers[bound_point] = instruct_point
    registers = exec_opcodes(actn[0], registers, actn[1..-1])
    instruct_point = registers[bound_point] + 1
  end
  puts registers[0]
end

input_file = File.readlines('day-19-input.txt').map(&:chomp)

part_one(input_file) # 1140
part_two(input_file) # 12474720
