require 'rubygems'
require 'sexp'
require 'extensions'

=begin
Каждому сообщению от сервера соответствует объект Status класса.
Объекты данного класа предоставляют простой интерфейс для получения информации о состоянии игры.

Пример,

  simple_server_sexp = '(time (now 696.94))(GYR (n torso) (rt -0.24 3.30 -0.06))'
  status = Status.new simple_server_sexp
  p status.time         # => 696.94
  p status.gyroscope    # => [-0.24, 3.3, -0.06]

=end

class Status
  def initialize(raw_sexp)
    sexp = raw_sexp.parse_sexp
    @data = make_nested sexp    
  end
  
  def make_nested(sexp)
    hash = {}
    sexp.each {|subsexp| hash[subsexp.shift] = (subsexp.first.is_a? Array) ? make_nested(subsexp) : subsexp }
    hash
  end
    
  def time
    @data[:time][:now].first
  end

  def game_time
    @data[:GS][:t].first
  end
  
  def game_mode
    @data[:GS][:pm].first
  end
  
  def gyroscope
    @data[:GYR][:rt]
  end
end