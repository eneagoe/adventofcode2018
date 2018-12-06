#!/usr/bin/env ruby -w

require 'awesome_print'

def manhattan_distance(x1, y1, x2, y2)
  (x1 - x2).abs + (y1 - y2).abs
end

input = ARGV[0]&.chomp || 'day6.in'
coords = File.open(input).readlines.map(&:chomp).map { |c| c.split(/,\s+/).map(&:to_i) }

# 1st puzzle
symbols = {}
coords.each_with_index { |c, i| symbols[c] = ('A'..'z').to_a[i] }

x1, x2 = coords.map { |c| c[0] }.minmax
y1, y2 = coords.map { |c| c[1] }.minmax

regions = []
bounded = 0

(y1..y2).each do |y|
  (x1..x2).each do |x|
    distances = coords.map { |c| [manhattan_distance(x, y, *c), c] }
    closest = distances.min_by(&:first)
    if distances.map(&:first).count(closest[0]) == 1
      regions << symbols[closest[1]]
    end
    # 2nd puzzle
    bounded += 1 if distances.map(&:first).sum < 10_000
  end
end

ap symbols.values.map { |s| regions.count(s) }.max

# 2nd puzzle
ap bounded
