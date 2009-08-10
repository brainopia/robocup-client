require 'lib/client/mapper'

Spec::Matchers.define :be_mapped_to do |mapped_hash|
  match do |mapper|
    mapped_hash.all? do |key, value|
      mapper[key] == value
    end
  end
end

describe Client::Mapper do
  describe 'general data' do
    it do
      Client::Mapper.new(:time => { :now => 'value' }).should be_mapped_to :time => 'value'
    end

    it do
      Client::Mapper.new(:GS => { :t => 'value' }).should be_mapped_to :game_time => 'value'
    end

    it do
      Client::Mapper.new(:GS => { :pm => 'value' }).should be_mapped_to :game_mode => 'value'
    end

    it do
      Client::Mapper.new(:GYR => { :torse => { :rt => 'value' }}).should be_mapped_to :gyroscope => 'value'
    end
  end

  describe 'force resistance' do
    it do
      Client::Mapper.new(:FRP => { :lf => 'value' }).should be_mapped_to :left_foot_force => 'value'
    end

    it do
      Client::Mapper.new(:FRP => { :rf => 'value' }).should be_mapped_to :right_foot_force => 'value'
    end
  end

  describe 'head' do
    it do
      Client::Mapper.new(:HJ => { :hj1 => { :ax => 'value' }}).should be_mapped_to :h1 => 'value'
    end
  
    it do
      Client::Mapper.new(:HJ => { :hj2 => { :ax => 'value' }}).should be_mapped_to :h2 => 'value'
    end
  end

  describe 'right arm' do
    it do
      Client::Mapper.new(:HJ => { :raj1 => { :ax => 'value' }}).should be_mapped_to :ra1 => 'value'
    end

    it do
      Client::Mapper.new(:HJ => { :raj2 => { :ax => 'value' }}).should be_mapped_to :ra2 => 'value'
    end

    it do
      Client::Mapper.new(:HJ => { :raj3 => { :ax => 'value' }}).should be_mapped_to :ra3 => 'value'
    end

    it do
      Client::Mapper.new(:HJ => { :raj4 => { :ax => 'value' }}).should be_mapped_to :ra4 => 'value'
    end
  end

  describe 'left arm' do
    it do
      Client::Mapper.new(:HJ => { :laj1 => { :ax => 'value' }}).should be_mapped_to :la1 => 'value'
    end

    it do
      Client::Mapper.new(:HJ => { :laj2 => { :ax => 'value' }}).should be_mapped_to :la2 => 'value'
    end

    it do
      Client::Mapper.new(:HJ => { :laj3 => { :ax => 'value' }}).should be_mapped_to :la3 => 'value'
    end

    it do
      Client::Mapper.new(:HJ => { :laj4 => { :ax => 'value' }}).should be_mapped_to :la4 => 'value'
    end
  end

  describe 'right leg' do
    it do
      Client::Mapper.new(:HJ => { :rlj1 => { :ax => 'value' }}).should be_mapped_to :rl1 => 'value'
    end

    it do
      Client::Mapper.new(:HJ => { :rlj2 => { :ax => 'value' }}).should be_mapped_to :rl2 => 'value'
    end

    it do
      Client::Mapper.new(:HJ => { :rlj3 => { :ax => 'value' }}).should be_mapped_to :rl3 => 'value'
    end

    it do
      Client::Mapper.new(:HJ => { :rlj4 => { :ax => 'value' }}).should be_mapped_to :rl4 => 'value'
    end

    it do
      Client::Mapper.new(:HJ => { :rlj5 => { :ax => 'value' }}).should be_mapped_to :rl5 => 'value'
    end

    it do
      Client::Mapper.new(:HJ => { :rlj6 => { :ax => 'value' }}).should be_mapped_to :rl6 => 'value'
    end
  end

  describe 'left leg' do
    it do
      Client::Mapper.new(:HJ => { :llj1 => { :ax => 'value' }}).should be_mapped_to :ll1 => 'value'
    end

    it do
      Client::Mapper.new(:HJ => { :llj2 => { :ax => 'value' }}).should be_mapped_to :ll2 => 'value'
    end

    it do
      Client::Mapper.new(:HJ => { :llj3 => { :ax => 'value' }}).should be_mapped_to :ll3 => 'value'
    end

    it do
      Client::Mapper.new(:HJ => { :llj4 => { :ax => 'value' }}).should be_mapped_to :ll4 => 'value'
    end

    it do
      Client::Mapper.new(:HJ => { :llj5 => { :ax => 'value' }}).should be_mapped_to :ll5 => 'value'
    end

    it do
      Client::Mapper.new(:HJ => { :llj6 => { :ax => 'value' }}).should be_mapped_to :ll6 => 'value'
    end
  end
end