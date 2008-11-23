$:.unshift File.join(File.dirname(__FILE__), '..', 'lib')
require 'benchmark'

module Benchmark
  def self.ms
    result = Benchmark.realtime { yield }.to_f * 1000
    puts "Elapsed time is #{result.to_i} ms"
  end
end