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
import re
import string

def part_one(input):
    point_map = []
    for h in range(400):
        point_map.append(['#'] * 400)
    points = []
    points_area = [0] * 50
    for vle in input:
        f, s = vle.split(', ')
        points.append([int(f), int(s)])
    for y in range(400):
        for x in range(400):
            not_eq_dist = True
            min_dist = 800000
            pnt = -1
            for index, point in enumerate(points):
                dist = abs(x - point[0]) + abs(y - point[1])
                if dist < min_dist:
                    min_dist = dist
                    pnt = index
                    not_eq_dist = True
                elif dist == min_dist:
                    not_eq_dist = False
            if not_eq_dist:
                point_map[y][x] = pnt
    outlier_points = []
    for op in range(400):
        if point_map[0][op] not in outlier_points:
            outlier_points.append(point_map[0][op])
        if point_map[op][0] not in outlier_points:
            outlier_points.append(point_map[op][0])
        if point_map[399][op] not in outlier_points:
            outlier_points.append(point_map[399][op])
        if point_map[op][399] not in outlier_points:
            outlier_points.append(point_map[op][399])
    for y_axis in range(400):
        for x_axis in range(400):
            if (point_map[y_axis][x_axis] != '#') and (point_map[y_axis][x_axis] not in outlier_points):
                value = point_map[y_axis][x_axis]
                points_area[value] += 1
    top = 0
    for area in points_area:
        if area > top:
            top = area
    print(top)

def part_two(input):
    point_map = []
    for h in range(400):
        point_map.append(['#'] * 400)
    points = []
    points_area = [0] * 50
    for vle in input:
        f, s = vle.split(', ')
        points.append([int(f), int(s)])
    region_area = 0
    for y in range(400):
        for x in range(400):
            dist = 0
            total_dist = 0
            for point in points:
                dist = abs(x - point[0]) + abs(y - point[1])
                total_dist += dist
            if total_dist < 10000:
                region_area += 1
    print(region_area)

input_file = open('day-6-input.txt', 'r').read().splitlines()
part_one(input_file) # 4016
part_two(input_file) # 46306
