#!/usr/bin/env ruby -w

input = ARGV[0]&.chomp || 'day3.in'

# 1st puzzle
squares = Hash.new(0)

File.open(input).each do |line|
  line =~ /\#\d+\s+\@\s+(\d+),(\d+):\s+(\d+)x(\d+)/
  x, y = $1.to_i, $2.to_i
  w, h = $3.to_i, $4.to_i
  (x...x+w).each do |i|
    (y...y+h).each do |j|
      squares[[j, i]] += 1
    end
  end
end

puts(squares.count { |_, v| v > 1 })

# 2nd puzzle - not very efficient, but fast enough
File.open(input).each do |line|
  line =~ /\#(\d+)\s+\@\s+(\d+),(\d+):\s+(\d+)x(\d+)/
  id = $1
  x, y = $2.to_i, $3.to_i
  w, h = $4.to_i, $5.to_i
  pristine = true
  (x...x+w).each do |i|
    (y...y+h).each do |j|
      if squares[[j, i]] != 1
        pristine = false
        break
      end
    end
    break unless pristine
  end
  puts id if pristine
end
