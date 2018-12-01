#!/usr/bin/env ruby -w

require 'set'

input = ARGV[0]&.chomp || 'day1.in'
frequencies = File.open(input).readlines.map(&:to_i)

# 1st puzzle
puts frequencies.sum

# 2nd puzzle
sums = Set.new
current_sum = 0
sums << current_sum
pos = 0

while true
  current_sum += frequencies[pos]
  break if sums.include?(current_sum)
  sums << current_sum
  pos = (pos + 1) % frequencies.size
end

puts current_sum
