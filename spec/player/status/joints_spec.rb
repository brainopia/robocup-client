require File.join(File.dirname(__FILE__), '../../spec_helper')
require 'player/status/joints'

describe Player::Status::Joints do
  before(:each) do
    @joints_status = Player::Status::Joints.new parsed_status_data
  end

  it "should return a status of H1 joint" do
    @joints_status.head[0].should == -0.00
  end
  
  it "should return a status of H2 joint" do
    @joints_status.head[1].should == 0.01
  end
  
  it "should return a status of RA1 joint" do
    @joints_status.right_arm[0].should == 121.08
  end
  
  it "should return a status of RA2 joint" do
    @joints_status.right_arm[1].should == -0.67
  end
  
  it "should return a status of RA3 joint" do
    @joints_status.right_arm[2].should == -0.01
  end
  
  it "should return a status of RA4 joint" do
    @joints_status.right_arm[3].should == 0.02
  end

  it "should return a status of LA1 joint" do
    @joints_status.left_arm[0].should == 0.25
  end
  
  it "should return a status of LA2 joint" do
    @joints_status.left_arm[1].should == 0.00
  end
  
  it "should return a status of LA3 joint" do
    @joints_status.left_arm[2].should == 0.01
  end
  
  it "should return a status of LA4 joint" do
    @joints_status.left_arm[3].should == -0.01
  end
    
  it "should return a status of RL1 joint" do
    @joints_status.right_leg[0].should == -0.20
  end
  
  it "should return a status of RL2 joint" do
    @joints_status.right_leg[1].should == -0.21
  end

  it "should return a status of RL3 joint" do
    @joints_status.right_leg[2].should == 1.91
  end

  it "should return a status of RL4 joint" do
    @joints_status.right_leg[3].should == -0.00
  end

  it "should return a status of RL5 joint" do
    @joints_status.right_leg[4].should == -0.13
  end
  
  it "should return a status of RL6 joint" do
    @joints_status.right_leg[5].should == -25.03
  end
  
  it "should return a status of LL1 joint" do
    @joints_status.left_leg[0].should == 0.02
  end
  
  it "should return a status of LL2 joint" do
    @joints_status.left_leg[1].should == 8.13
  end

  it "should return a status of LL3 joint" do
    @joints_status.left_leg[2].should == 1.60
  end

  it "should return a status of LL4 joint" do
    @joints_status.left_leg[3].should == -0.00
  end

  it "should return a status of LL5 joint" do
    @joints_status.left_leg[4].should == 0.01
  end
  
  it "should return a status of LL6 joint" do
    @joints_status.left_leg[5].should == -46.02
  end
end
