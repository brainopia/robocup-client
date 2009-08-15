require 'lib/robot'

describe Robot do
  it 'should notify observers when there is new data' do
    Robot.observers[:test] = lambda { throw :notified }
    lambda { Robot.data = {:new => 'data' }}.should throw_symbol :notified
  end
end