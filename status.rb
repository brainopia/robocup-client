require 'rubygems'
require 'sexp'
require 'extensions'

class Status  
  ROOT_SEXPS = {
    :time => [:now],
    :gs   => [:t, :pm],
    :gyr  => [:n, :rt],
    :hj   => [:n, :ax],
    :frp  => [:n, :c, :f],
    :see  => visible_objects = [:g1l, :g2l, :g2r, :g1r, :f1l, :f2l, :f1r, :f2r, :b]    
  }  
  
  NESTED_SEXPS = { visible_objects => [:pol] }

  SexpTree = Struct.new *ROOT_SEXPS.keys
  
  (ROOT_SEXPS + NESTED_SEXPS).each do |name, args|
    struct = Struct.new *args
    Array(name).each {|name| const_set name.capitalize, struct }
  end
  
  def initialize(raw_sexp)
    @tree = SexpTree.new
    raw_sexp.downcase.parse_sexp.each do |data_item|
      structurize(data_item) {|type, content| @tree[type] = content }
    end
  end
  
  def structurize(data)
    data_name = data.shift
    if data.first.is_a? Array
      data_class = self.class.const_get data_name.capitalize
      data_struct = data_class.new
      data.each {|item| structurize(item) {|type, content| data_struct[type] = content }}      
    else
      data_struct = data
    end
    yield data_name, data_struct
  end
  
  def self.alias_data(method_name, data_location)
    value = "@tree.#{data_location}"
    define_method(method_name) { eval value }
  end
  
  DATA_ALIASES = {
    :time => 'time.now.first',
    :game_time => 'gs.t.first',
    :game_mode => 'gs.pm.first',
    :gyroscope => 'gyr.rt'
  }
  
  DATA_ALIASES.each {|method_name, data_location| alias_data method_name, data_location }
end

# Example
test_data = '(time (now 696.94))(GS (t 0.00) (pm BeforeKickOff))(GYR (n torso) (rt -0.24 3.30 -0.06))(See (G1L (pol 1.06 139.50 -10.86)) (G2L (pol 1.47 138.02 53.98)) (G2R (pol 11.31 3.42 -0.56)) (G1R (pol 11.26 3.98 -7.64)) (F1L (pol 3.71 174.23 -71.85)) (F2L (pol 4.43 -121.88 83.03)) (F1R (pol 11.81 1.13 -24.12)) (F2R (pol 12.06 -1.77 14.92)) (B (pol 5.25 -0.88 -2.29)))(HJ (n hj1) (ax -0.00))(HJ (n hj2) (ax 0.00))(HJ (n raj1) (ax 121.08))(HJ (n raj2) (ax -0.67))(HJ (n raj3) (ax -0.01))(HJ (n raj4) (ax 0.02))(HJ (n laj1) (ax 0.25))(HJ (n laj2) (ax 0.00))(HJ (n laj3) (ax 0.01))(HJ (n laj4) (ax -0.01))(HJ (n rlj1) (ax -0.20))(HJ (n rlj2) (ax -0.20))(HJ (n rlj3) (ax 1.91))(HJ (n rlj4) (ax -0.00))(HJ (n rlj5) (ax -0.13))(FRP (n rf) (c 0.04 0.02 -0.02) (f -19.47 1.76 -5.97))(HJ (n rlj6) (ax -25.03))(HJ (n llj1) (ax 0.02))(HJ (n llj2) (ax 8.13))(HJ (n llj3) (ax 1.60))(HJ (n llj4) (ax -0.00))(HJ (n llj5) (ax 0.01))(HJ (n llj6) (ax -46.02))'

status = Status.new test_data
p status.time
p status.game_time
p status.game_mode
p status.gyroscope