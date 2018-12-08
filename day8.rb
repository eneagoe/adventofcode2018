#!/usr/bin/env ruby -w

require 'awesome_print'

input = ARGV[0]&.chomp || 'day8.in'

nodes = File.open(input).read.chomp.split(/\s+/).map(&:to_i)

# Pass me a block telling me what to do with [child_values, metadata_values]
def val(a, &b)
  n_children = a.shift
  n_metadata = a.shift
  yield(n_children.times.map { val(a, &b) }, a.shift(n_metadata))
end

puts val(nodes.dup) { |child, meta| child.sum + meta.sum }

puts val(nodes.dup) { |child, meta|
  # metadata indices are 1-indexed, so just prepend a zero.
  child.unshift(0)
  child.size == 1 ? meta.sum : meta.sum { |x| child[x] || 0 }
}

def metasum(nodes, sum)
  return 0 if nodes.empty?

  children = nodes.shift
  meta = nodes.shift

  children.times do
    sum += metasum(nodes, 0)
  end

  sum + nodes.shift(meta).sum
end

# 1st puzzle
ap metasum(nodes.dup, 0)

# TODO: 2nd puzzle
