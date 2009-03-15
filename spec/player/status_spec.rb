require File.join(File.dirname(__FILE__), '../spec_helper')
require 'player/status'

describe Player::Status do
  before(:all) do
    @status = Player::Status
    @status.data = status_data
  end

  it "should return time" do
    @status.time.should == 696.94
  end
  
  it "should return a game time" do
    @status.game_time.should == 0.00
  end
  
  it "should return a game mode" do
    @status.game_mode.should == :BeforeKickOff
  end
  
  it "should return a gyroscope state" do
    @status.gyroscope.should == [-0.24, 3.30, -0.06]
  end  
end