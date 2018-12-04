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
require 'date'

# Part One
def part_one(input)
  guard_id = ''
  total_sleep_time = {}
  sleep_range = {}
  timestamp = {:asleep => '', :wakeup => ''}
  # json-y idea guards => { guardid => { total_sleep_time, [range], {sorted range} } }
  # guardid => [total_sleep_time, [range]]
  input.each do |line|
    if line.include? 'shift'
      guard_id = line.scan(/#\d+/)[0][1..-1].to_i
      total_sleep_time[guard_id] = 0 if total_sleep_time[guard_id].nil?
      sleep_range[guard_id] = [] if sleep_range[guard_id].nil?
    elsif line.include? 'asleep'
      (dt, action) = line.split(']')
      dt = dt[1..-1]
      timestamp[:asleep] = DateTime.parse(dt)
    elsif line.include? 'wakes'
      (dt, action) = line.split(']')
      dt = dt[1..-1]
      timestamp[:wakeup] = DateTime.parse(dt)
      time_asleep = timestamp[:wakeup] - timestamp[:asleep]
      sleep_range[guard_id].push(*(timestamp[:asleep].min.to_i..timestamp[:wakeup].min.to_i-1))
      total_sleep_time[guard_id] += time_asleep
    end
  end
  gid = 0
  total = 0
  total_sleep_time.each do |key, value|
    if value > total
      gid = key
      total = value
    end
  end
  minutes = (0..59).inject({}) {|hash, i| hash[i] = 0; hash}
  sleep_range[gid].each do |sr|
    minutes[sr] += 1
  end
  puts minutes.sort_by {|_k, v| v}.to_h
  puts gid * 25
end

def part_two(input)
  guard_id = 0
  guards = {}
  guard_mode_time = {}
  asleep = ''
  wakeup = ''
  # json-y idea guards => { guardid => { total_sleep_time, [range], {sorted range} } }
  # json-y idea v2.0 guards => { guardid => [ total_sleep_time, mode_time, how_frequent_mode] }
  # guardid => [range]
  input.each do |line|
    if line.include? 'shift'
      guard_id = line.scan(/#\d+/)[0][1..-1].to_i
      guards[guard_id] = [0, 0, 0] if guards[guard_id].nil?
      guard_mode_time[guard_id] = [] if guard_mode_time[guard_id].nil?
    elsif line.include? 'asleep'
      (dt, action) = line.split(']')
      dt = dt[1..-1]
      asleep = DateTime.parse(dt)
    elsif line.include? 'wakes'
      (dt, action) = line.split(']')
      dt = dt[1..-1]
      wakeup = DateTime.parse(dt)
      time_asleep = wakeup - asleep
      guard_mode_time[guard_id].push(*(asleep.min.to_i..wakeup.min.to_i-1))
      guards[guard_id][0] += time_asleep
    end
  end
  guard_mode_time.each do |k,v|
    minutes = (0..59).inject({}) {|hash, i| hash[i] = 0; hash}
    v.each do |sr|
      minutes[sr] += 1
    end
    minutes.each do |f,s|
      if guards[k][2] < s
        guards[k][1] = f
        guards[k][2] = s
      end
    end
  end
  most_freq = 0
  mint = 0
  gid = 0
  guards.each do |g,d|
    if d[2] > most_freq
      most_freq = d[2]
      mint = d[1]
      gid = g
    end
  end
  puts gid * mint
end

# Sorted the lines when saving the input file
input_file = File.readlines('day-4-input.txt')
part_one(input_file) # 2917 * 25 = 72925
part_two(input_file) # 49137
