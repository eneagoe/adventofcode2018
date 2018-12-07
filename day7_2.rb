#!/usr/bin/env ruby -w

require 'awesome_print'

input = ARGV[0]&.chomp || 'day7.in'

tree = Hash.new { |h, key| h[key] = [] }
degrees = Hash.new { |h, key| h[key] = 0 }

File.open(input).each do |line|
  line =~ /Step (\w+) must be finished before step (\w+) can begin/
  tree[$1] << $2
  degrees[$2] += 1
end

tree.each do |k, v|
  tree[k] = v.sort
end

# 2nd puzzle
def work
  # as long as we have place in the processing queue, and there are jobs enqueued ...
  while @events.size < 5 && !@work_queue.empty?
    next_job = @work_queue.min # pick the next lexicographic job
    @work_queue = @work_queue.select { |j| j != next_job } # remove it from queue ...
    @events.append [@t + 61 + next_job.ord - 'A'.ord, next_job] # and add it to processing queue
  end
end

@t = 0 # starting time
@events = [] # [duration, job]
@work_queue = []

# start enqueueing jobs that depend on none other
tree.keys.each do |job|
  if degrees[job].zero?
    @work_queue.append(job)
  end
end
work

# as long as there are jobs in process or enqueued ....
while !@events.empty? || !@work_queue.empty?
  @t, job = @events.min # pick the next job to finish ...
  @events = @events.select { |j| j != [@t, job] } # remove it from processing
  tree[job].each do |task|
    degrees[task] -= 1 # child jobs now depend on one less job ...
    @work_queue.append(task) if degrees[task].zero? # so enqueue them if ready
  end
  work
end

puts @t
