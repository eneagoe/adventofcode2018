#!/usr/bin/env ruby -w

require 'awesome_print'

input = ARGV[0]&.chomp || 'day4.in'
timetable = File.open(input).readlines.map(&:chomp)

# sort the timetable first
timetable.sort_by! do |line|
  line =~ /(\d+)-(\d+)-(\d+)\s+(\d+):(\d+)/
  [$1.to_i, $2.to_i, $3.to_i, $4.to_i, $5.to_i]
end

# 1st puzzle
minutes = Hash.new { |h, k| h[k] = [0] * 60 }
current_guard = nil
sleep_start = 0

timetable.each do |line|
  case line
  when /Guard\s+\#(\d+)/
    current_guard = $1
    # puts "Guard: #{current_guard}"
  when /\d+-\d+-\d+\s+\d+:(\d+)\]\s+falls\s+asleep/
    sleep_start = $1.to_i
    # puts "asleep at #{sleep_start}"
  when /\d+-\d+-\d+\s+\d+:(\d+)\]\s+wakes\s+up/
    # puts "awoke at #{$1}"
    (sleep_start...$1.to_i).each do |i|
      # puts "increasing minutes #{i} for #{current_guard}"
      minutes[current_guard][i] += 1
    end
  end
end

guard = minutes.max_by do |k, m|
  m.sum
end

ap guard[0]
ap guard[1].index(guard[1].max)
ap guard[0].to_i * guard[1].index(guard[1].max)

# 2nd puzzle
guard = minutes.max_by do |k, m|
  m.max
end

ap guard[0]
ap guard[1].index(guard[1].max)
ap guard[0].to_i * guard[1].index(guard[1].max)
