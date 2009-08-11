require 'lib/client/mapper'

Spec::Matchers.define :be_mapped_to do |mapped_hash|
  match do |block|
    mapper = block.call
    mapped_hash.all? do |key, value|
      mapper[key] == value && mapper.__send__(key) == value
    end
  end
end

describe Client::Mapper do
  def hash(data)
    expect { Client::Mapper.new(data) }
  end

  it 'should store original hash with perceptors' do
    perceptors = {:a => 1, :b => 2}
    Client::Mapper.new(perceptors).data.should == perceptors
  end

  describe 'general data' do
    it { hash(:time => { :now => :value }).           should be_mapped_to :time => :value }
    it { hash(:GS => { :t => :value }).               should be_mapped_to :game_time => :value }
    it { hash(:GS => { :pm => :value }).              should be_mapped_to :game_mode => :value }
    it { hash(:GYR => { :torse => { :rt => :value }}).should be_mapped_to :gyroscope => :value }
  end

  describe 'force resistance' do
    it { hash(:FRP => { :lf => 'value' }).should be_mapped_to :left_foot_force => 'value' }
    it { hash(:FRP => { :rf => 'value' }).should be_mapped_to :right_foot_force => 'value' }
  end

  describe 'head' do
    it { hash(:HJ => { :hj1 => { :ax => 'value' }}).should be_mapped_to :h1 => 'value' }
    it { hash(:HJ => { :hj2 => { :ax => 'value' }}).should be_mapped_to :h2 => 'value' }
  end

  describe 'right arm' do
    it { hash(:HJ => { :raj1 => { :ax => 'value' }}).should be_mapped_to :ra1 => 'value' }
    it { hash(:HJ => { :raj2 => { :ax => 'value' }}).should be_mapped_to :ra2 => 'value' }
    it { hash(:HJ => { :raj3 => { :ax => 'value' }}).should be_mapped_to :ra3 => 'value' }
    it { hash(:HJ => { :raj4 => { :ax => 'value' }}).should be_mapped_to :ra4 => 'value' }
  end

  describe 'left arm' do
    it { hash(:HJ => { :laj1 => { :ax => 'value' }}).should be_mapped_to :la1 => 'value' }
    it { hash(:HJ => { :laj2 => { :ax => 'value' }}).should be_mapped_to :la2 => 'value' }
    it { hash(:HJ => { :laj3 => { :ax => 'value' }}).should be_mapped_to :la3 => 'value' }
    it { hash(:HJ => { :laj4 => { :ax => 'value' }}).should be_mapped_to :la4 => 'value' }
  end

  describe 'right leg' do
    it { hash(:HJ => { :rlj1 => { :ax => 'value' }}).should be_mapped_to :rl1 => 'value' }
    it { hash(:HJ => { :rlj2 => { :ax => 'value' }}).should be_mapped_to :rl2 => 'value' }
    it { hash(:HJ => { :rlj3 => { :ax => 'value' }}).should be_mapped_to :rl3 => 'value' }
    it { hash(:HJ => { :rlj4 => { :ax => 'value' }}).should be_mapped_to :rl4 => 'value' }
    it { hash(:HJ => { :rlj5 => { :ax => 'value' }}).should be_mapped_to :rl5 => 'value' }
    it { hash(:HJ => { :rlj6 => { :ax => 'value' }}).should be_mapped_to :rl6 => 'value' }
  end

  describe 'left leg' do
    it { hash(:HJ => { :llj1 => { :ax => 'value' }}).should be_mapped_to :ll1 => 'value' }
    it { hash(:HJ => { :llj2 => { :ax => 'value' }}).should be_mapped_to :ll2 => 'value' }
    it { hash(:HJ => { :llj3 => { :ax => 'value' }}).should be_mapped_to :ll3 => 'value' }
    it { hash(:HJ => { :llj4 => { :ax => 'value' }}).should be_mapped_to :ll4 => 'value' }
    it { hash(:HJ => { :llj4 => { :ax => 'value' }}).should be_mapped_to :ll4 => 'value' }
    it { hash(:HJ => { :llj5 => { :ax => 'value' }}).should be_mapped_to :ll5 => 'value' }
    it { hash(:HJ => { :llj6 => { :ax => 'value' }}).should be_mapped_to :ll6 => 'value' }
  end
end