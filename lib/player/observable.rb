module Player
  # TODO: think about reimplementing
  
  def data=(new_data)
    notify :before_every_cycle, new_data
    old_data = data.clone
    data.merge!(new_data) do |perceptor, old_value, new_value|
      notify(perceptor, old_value, new_value) unless old_value == new_value
      new_value
    end
    notify :after_every_cycle, old_data
  end
  
  @observers = Hash.new {|hash, new_perceptor| hash[new_perceptor] = {} }
  @callbacks = Hash.new {|hash, new_perceptor| hash[new_perceptor] = [] }

  def after_every_cycle(name=nil, &callback)
    if name
      @observers[:after_every_cycle][name] = callback
    else
      @callbacks[:after_every_cycle] << callback
    end
  end

  def before_every_cycle(name=nil, &callback)
    if name
      @observers[:before_every_cycle][name] = callback
    else
      @callbacks[:before_every_cycle] << callback
    end
  end
  
  def add_callback(perceptor, &callback)
    @callbacks[perceptor] << callback
  end

  def add_observer(perceptor, name, &callback)
    @observers[perceptor][name] = callback
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