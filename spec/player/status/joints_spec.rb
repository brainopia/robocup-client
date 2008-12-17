require File.join(File.dirname(__FILE__), '../../spec_helper')
require 'player/status/joints'

describe Player::Status::Joints do
  before(:each) do
    @joints_status = Player::Status::Joints.new parsed_status_data
  end

  it "should return a status of H1 joint" do
    @joints_status.h1.should == -0.00
  end
  
  it "should return a status of H2 joint" do
    @joints_status.h2.should == 0.01
  end
  
  it "should return a status of RA1 joint" do
    @joints_status.ra1.should == 121.08
  end
  
  it "should return a status of RA2 joint" do
    @joints_status.ra2.should == -0.67
  end
  
  it "should return a status of RA3 joint" do
    @joints_status.ra3.should == -0.01
  end
  
  it "should return a status of RA4 joint" do
    @joints_status.ra4.should == 0.02
  end

  it "should return a status of LA1 joint" do
    @joints_status.la1.should == 0.25
  end
  
  it "should return a status of LA2 joint" do
    @joints_status.la2.should == 0.00
  end
  
  it "should return a status of LA3 joint" do
    @joints_status.la3.should == 0.01
  end
  
  it "should return a status of LA4 joint" do
    @joints_status.la4.should == -0.01
  end
    
  it "should return a status of RL1 joint" do
    @joints_status.rl1.should == -0.20
  end
  
  it "should return a status of RL2 joint" do
    @joints_status.rl2.should == -0.21
  end

  it "should return a status of RL3 joint" do
    @joints_status.rl3.should == 1.91
  end

  it "should return a status of RL4 joint" do
    @joints_status.rl4.should == -0.00
  end

  it "should return a status of RL5 joint" do
    @joints_status.rl5.should == -0.13
  end
  
  it "should return a status of RL6 joint" do
    @joints_status.rl6.should == -25.03
  end
  
  it "should return a status of LL1 joint" do
    @joints_status.ll1.should == 0.02
  end
  
  it "should return a status of LL2 joint" do
    @joints_status.ll2.should == 8.13
  end

  it "should return a status of LL3 joint" do
    @joints_status.ll3.should == 1.60
  end

  it "should return a status of LL4 joint" do
    @joints_status.ll4.should == -0.00
  end

  it "should return a status of LL5 joint" do
    @joints_status.ll5.should == 0.01
  end
  
  it "should return a status of LL6 joint" do
    @joints_status.ll6.should == -46.02
  end
end
