#!/usr/bin/env ruby -w

input = ARGV[0]&.chomp || 'day2.in'
codes = File.open(input).readlines.map(&:chomp)

# 1st puzzle
count2 = codes.count do |code|
  code.split(//).detect { |letter| code.count(letter) == 2 }
end

count3 = codes.count do |code|
  code.split(//).detect { |letter| code.count(letter) == 3 }
end

puts(count2 * count3)

# 2nd puzzle
(1...codes.size).each do |i|
  differences = 0
  (0...i).each do |j|
    differences = (0...codes[i].size).sum { |k| codes[i][k] != codes[j][k] ? 1 : 0 }
    if differences == 1
      puts(codes[i], codes[j])
      break
    end
  end
  break if differences == 1
end
