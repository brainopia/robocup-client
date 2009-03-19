require 'robocup/joints'

module Player
  module Status
=begin
  Модуль статуса расширяется данным модулем, чтобы поддерживать вызов наблюдателей при изменении заданных персепторов
  Player.status.add_perceptor_observer(:FMP) {|old_value, new_value| puts "FMP changed from #{old_value} to #{new_value}" }
  Player.status.add_joint_observer(:h1) {|old_value, new_value| puts "head joint 1 changed from #{old_value} to #{new_value}" }
=end
    
    module Observable
      def self.extended(object)
        object.instance_variable_set :@observers, Hash.new {|hash, new_perceptor| hash[new_perceptor] = [] }
      end
      
      def add_perceptor_observer(perceptor, &observer)
        @observers[perceptor] << observer
      end
      
      def add_joint_observer(joint, &observer)
        perceptor = Robocup::Joints.perceptors[joint]
        @observers[perceptor] << observer
      end
      
      # Если наблюдатель бросает :done при его вызове, то мы убираем его из массива наблюдателей
      def notify_observers(perceptor, old_value, new_value)
        @observers[perceptor].reject! do |observer|
          catch(:done) do
            observer.call old_value, new_value
            next false # перейти к следующему обсерверу, не удаляя текущий
          end
          next true # перейти к следующему обсерверу, удалив текущий
        end
      end
      
    end
  end
end