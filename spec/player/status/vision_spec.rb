require File.join(File.dirname(__FILE__), '../../spec_helper')
require 'player/status'
require 'player/status/vision'

describe Player::Status::Vision do
  before(:each) do
    @status = Player::Status
    @status.data = status_data    
    @vision_status = Player::Status::Vision
  end

  it "should return G1L coordinates" do
    @vision_status.goal1[0].should == [1.06, 139.50, -10.86]
  end
  
  it "should return G2L coordinates" do
    @vision_status.goal2[0].should == [1.47, 138.02, 53.98]
  end
  
  it "should return G1R coordinates" do
    @vision_status.goal1[1].should == [11.26, 3.98, -7.64]
  end
  
  it "should return G2R coordinates" do
    @vision_status.goal2[1].should == [11.31, 3.42, -0.56]
  end
  
  it "should return F1L coordinates" do
    @vision_status.field[0].should == [3.71, 174.23, -71.85]
  end
  
  it "should return F2L coordinates" do
    @vision_status.field[1].should == [4.43, -121.88, 83.03]
  end
  
  it "should return F1R coordinates" do
    @vision_status.field[2].should == [11.81, 1.13, -24.12]
  end
  
  it "should return F2R coordinates" do
    @vision_status.field[3].should == [12.06, -1.77, 14.92]
  end
  
  it "should return ball coordinates" do
    @vision_status.ball.should == [5.25, -0.88, -2.29]
  end  
  
  it "status should have a vision method" do
    @status.vision.should == Player::Status::Vision
  end  
end