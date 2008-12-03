require 'robocup/parser'

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
    include Robocup::Parser
  
    def initialize(sexp)
      @data = parse sexp    
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
  end
end