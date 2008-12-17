require 'robocup/parser'
require 'player/status/vision'
require 'player/status/joints'
require 'player/status/force'

module Player

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
    attr_reader :vision, :joints, :force
    
    def initialize(sexp)
      @data = Robocup::Parser.parse sexp  
      @vision, @joints, @force = Vision.new(@data), Joints.new(@data), Force.new(@data)
    end
      
    def time
      @data[:time][:now]
    end

    def game_time
      @data[:GS][:t]
    end
  
    def game_mode
      @data[:GS][:pm]
    end
  
    def gyroscope
      @data[:GYR][:torso][:rt]
    end
        
  end # Status
end # Player