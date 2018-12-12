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

def part_one(input)
  initial_state = input[0]
  initial_state.gsub!(/^.*: /, '')
  rules = {}

  2.upto(input.length - 1) do |line|
    key, value = input[line].split(' => ')
    rules[key] = value
  end

  gen = Hash.new('.')
  (0..initial_state.length - 1).each do |p|
    gen[p] = initial_state[p]
  end

  # starting at -2, but 0
  1.upto(20) do
    next_gen = Hash.new('.')
    min_pot = gen.keys.min - 2
    max_pot = gen.keys.max + 2
    (min_pot..max_pot).each do |pot|
      plant_state = ''
      (pot-2..pot+2).each do |s|
        plant_state += gen[s]
      end
      next_gen[pot] = rules[plant_state]
    end
    gen = next_gen
  end
  sum = 0
  gen.each do |key,value|
    if value == '#'
      sum += key
    end
  end
  puts sum
end

def part_two(input)
    initial_state = input[0]
  initial_state.gsub!(/^.*: /, '')
  rules = {}

  2.upto(input.length - 1) do |line|
    key, value = input[line].split(' => ')
    rules[key] = value
  end

  gen = Hash.new('.')
  (0..initial_state.length - 1).each do |p|
    gen[p] = initial_state[p]
  end

  # starting at -2, but 0
  1.upto(50000000000) do
    next_gen = Hash.new('.')
    min_pot = gen.keys.min - 2
    max_pot = gen.keys.max + 2
    (min_pot..max_pot).each do |pot|
      plant_state = ''
      (pot-2..pot+2).each do |s|
        plant_state += gen[s]
      end
      next_gen[pot] = rules[plant_state]
    end
    gen = next_gen
  end
  sum = 0
  gen.each do |key,value|
    if value == '#'
      sum += key
    end
  end
  puts sum
end

input_file = File.readlines('day-12-input.txt').map(&:chomp)

part_one(input_file) # 3405
part_two(input_file) # 3350000000000
