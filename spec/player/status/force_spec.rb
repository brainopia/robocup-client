require File.join(File.dirname(__FILE__), '../../spec_helper')
require 'player/status'
require 'player/status/force'

describe Player::Status::Force do
  before(:each) do    
    @status = Player::Status
    @status.data = status_data
    @force_status = Player::Status::Force
  end

  it "should return a force resistance perceptor for a right foot" do
    @force_status.right_foot == { :c => [0.04, 0.02, -0.02], :f => [-19.47, 1.76, -5.97]}
  end
  
  it "should return a force resistance perceptor for a right foot" do
    @force_status.left_foot == { :c => [0.05, 0.03, -0.01], :f => [-19.46, 1.77, -5.96]}
  end
  
  it "status should have a force method" do
    @status.force.should == Player::Status::Force
  end
end