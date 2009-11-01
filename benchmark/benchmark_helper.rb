$:.unshift File.join(File.dirname(__FILE__), '..', 'lib')
require 'benchmark'

module Benchmark
  def self.ms(&proc)
    result = Benchmark.realtime(&proc).to_f * 1000
    puts "Elapsed time is #{result.to_i} ms"
  end
end