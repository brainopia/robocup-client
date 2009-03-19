module Player
=begin
  Модуль статуса расширяется данным модулем, чтобы поддерживать вызов наблюдателей при изменении заданных персепторов.
  Пример, в котором будет отображаться информация об изменении угла для h1, пока величина угла не достигнет 10 градусов.
  Player.add_observer(:h1) do |old_value, new_value|   
    puts "Угол соединения h1 изменился от #{old_value} к #{new_value}."  
    throw :done if new_value.abs > 10
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