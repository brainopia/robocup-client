# TODO: add vision perceptors when we'll need them
module Client
  class Mapper < BasicObject

    attr_reader :data

    def initialize(data)
      @data = data 
    end

    def [](key)
      __send__ key
    end    

    map = {
      'time'       => 'time now',
      'game_time'  => 'GS t',
      'game_mode'  => 'GS pm',
      'gyroscope'  => 'GYR torse rt',
      
      'left_foot_force'  => 'FRP lf',
      'right_foot_force' => 'FRP rf',
      
      'h1' => 'HJ hj1 ax',
      'h2' => 'HJ hj2 ax',
      
      'ra1' => 'HJ raj1 ax',
      'ra2' => 'HJ raj2 ax',
      'ra3' => 'HJ raj3 ax',
      'ra4' => 'HJ raj4 ax',

      'la1' => 'HJ laj1 ax',
      'la2' => 'HJ laj2 ax',
      'la3' => 'HJ laj3 ax',
      'la4' => 'HJ laj4 ax',

      'rl1' => 'HJ rlj1 ax',
      'rl2' => 'HJ rlj2 ax',
      'rl3' => 'HJ rlj3 ax',
      'rl4' => 'HJ rlj4 ax',
      'rl5' => 'HJ rlj5 ax',
      'rl6' => 'HJ rlj6 ax',
      
      'll1' => 'HJ llj1 ax',
      'll2' => 'HJ llj2 ax',
      'll3' => 'HJ llj3 ax',
      'll4' => 'HJ llj4 ax',
      'll5' => 'HJ llj5 ax',
      'll6' => 'HJ llj6 ax'
    }

    map.each do |method_name, keys|
      rubified_keys = keys.split.map {|it| "[:#{it}]" }.join

      eval <<-CODE
        def #{method_name}
          @data#{rubified_keys}
        end
      CODE
    end
    
  end
end