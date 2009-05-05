module Player
  
  def data=(new_data)    
    notify :new_cycle, new_data
    data.merge!(new_data) do |perceptor, old_value, new_value|
      notify(perceptor, old_value, new_value) unless old_value == new_value
      new_value
    end
  end
  
  @observers = Hash.new {|hash, new_perceptor| hash[new_perceptor] = {} }
  @callbacks = Hash.new {|hash, new_perceptor| hash[new_perceptor] = [] }

  def every_cycle(&callback)
    @callbacks[:new_cycle] << callback
  end

  def add_callback(perceptor, &observer)
    @callbacks[perceptor] << observer
  end

  def add_observer(perceptor, name, &observer)
    @observers[perceptor][name] = observer
  end

  def remove_observer(perceptor, name)
    @observers[perceptor].delete name
  end
  
  private
  
  def notify(perceptor, *args)
    execute_observers perceptor, args
    execute_callbacks perceptor, args
  end
  
  def execute_observers(perceptor, args)
    @observers[perceptor].each do |name, observer|
      observer.call *args if observer
    end
  end
  
  def execute_callbacks(perceptor, args)
    @callbacks[perceptor].reject! do |callback|
      block_done? callback, args
    end
  end
  
  def block_done?(block, args)
    catch(:done) { block.call *args; return false }
    return true
  end  
end