#!/usr/bin/env ruby -w

def react(polymer:)
  i = 0
  while i < polymer.size - 1
    if (polymer[i].ord - polymer[i + 1].ord).abs == 32
      polymer.slice!(i..i+1)
      i -= 1 unless i.zero?
    else
      i += 1
    end
  end

  polymer
end

input = File.open(ARGV[0]&.chomp || 'day5.in').read.chomp

# 1st puzzle
result = react(polymer: input.dup)
puts result.size

# 2nd puzzle
result = ('a'..'z').map do |c|
  s = input.dup
  react(polymer: s.gsub(/#{c}/i, ''))
end.min_by(&:size)

puts result.size
