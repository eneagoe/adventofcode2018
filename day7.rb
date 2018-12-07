#!/usr/bin/env ruby -w

require 'awesome_print'
require 'set'

input = ARGV[0]&.chomp || 'day7.in'

tree = Hash.new { |h, key| h[key] = [] }
symbols = Set.new

File.open(input).each do |line|
  line =~ /Step (\w+) must be finished before step (\w+) can begin/
  tree[$1] << $2
  symbols.add($1)
  symbols.add($2)
end

tree.each do |k, v|
  tree[k] = v.sort
end

order = []

# 1st puzzle - lexicographical topological sorting
while !symbols.empty?
  degrees = symbols.map do |s|
    [s, tree.sum { |_, v| v.count(s) }]
  end
  last = degrees.sort_by { |d| [d[1], d[0]] }.first[0]
  order << last

  symbols.delete(last)
  tree.delete(last)
  tree.each do |k, v|
    v.delete(last)
  end
end

puts order.join('')

