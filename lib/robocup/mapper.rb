module Robocup
  class Mapper < Hash
  
    # TODO: add vision perceptors when we'll need them
    def initialize(data)
      super
      self[:time] = data[:time][:now]
      self[:game_time] = data[:GS][:t]
      self[:game_mode] = data[:GS][:pm]
      self[:gyroscope] = data[:GYR][:torso][:rt]

      # TODO: uncomment it when we'll need force resistance
      # self[:left_foot_force] = [data[:FRP][:lf][:c], data[:FRP][:lf][:f]]
      # self[:right_foot_force] = [data[:FRP][:rf][:c], data[:FRP][:rf][:f]]
    
      self[:h1] = data[:HJ][:hj1][:ax]
      self[:h2] = data[:HJ][:hj2][:ax]

      self[:ra1] = data[:HJ][:raj1][:ax]    
      self[:ra2] = data[:HJ][:raj2][:ax]
      self[:ra3] = data[:HJ][:raj3][:ax]
      self[:ra4] = data[:HJ][:raj4][:ax]
    
      self[:la1] = data[:HJ][:laj1][:ax]    
      self[:la2] = data[:HJ][:laj2][:ax]
      self[:la3] = data[:HJ][:laj3][:ax]
      self[:la4] = data[:HJ][:laj4][:ax]
    
      self[:rl1] = data[:HJ][:rlj1][:ax]    
      self[:rl2] = data[:HJ][:rlj2][:ax]
      self[:rl3] = data[:HJ][:rlj3][:ax]
      self[:rl4] = data[:HJ][:rlj4][:ax]
      self[:rl5] = data[:HJ][:rlj5][:ax]
      self[:rl6] = data[:HJ][:rlj6][:ax]
    
      self[:ll1] = data[:HJ][:llj1][:ax]    
      self[:ll2] = data[:HJ][:llj2][:ax]
      self[:ll3] = data[:HJ][:llj3][:ax]
      self[:ll4] = data[:HJ][:llj4][:ax]
      self[:ll5] = data[:HJ][:llj5][:ax]
      self[:ll6] = data[:HJ][:llj6][:ax]    
    end
  end
end