require 'robocup/joints'

module Player
=begin
  Модуль статуса расширяется данным модулем, чтобы поддерживать вызов наблюдателей при изменении заданных персепторов
  Player.add_observer(:h1) do |old_value, new_value| 
    puts "head joint 1 changed from #{old_value} to #{new_value}"
    if new_value.abs > 10
      Player.joint.h1 0
      throw :done 
    end
  end
=end
  module Observable
    def self.extended(object)
      object.instance_variable_set :@observers, Hash.new {|hash, new_perceptor| hash[new_perceptor] = [] }
    end
    
    def add_observer(perceptor, &observer)
      @observers[perceptor] << observer
    end
        
    # Если наблюдатель бросает :done при его вызове, то мы убираем его из массива наблюдателей
    def notify_observers(perceptor, old_value, new_value)
      @observers[perceptor].reject! do |observer|
        next true unless catch(:done) { observer.call old_value, new_value; true }  
      end
    end
    
  end
end