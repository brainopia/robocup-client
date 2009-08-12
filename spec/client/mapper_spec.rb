require 'lib/client/mapper'

describe Client::Mapper do
  alias contain include

  before(:all) do
    # hack so we can test mapper with not-complete data
    def nil.[](a) end
  end

  after(:all) do
    class <<nil; undef_method :[] end
  end

  def mapper_for(data)
    Client::Mapper.new data
  end

  describe 'general data' do
    before(:all) do
      @mapper = mapper_for :time => { :now => :value1 },
                           :GS   => { :t => :value2, :pm => :value3 },
                           :GYR  => { :torso => { :rt => :value4 }}
    end
    
    it 'should map to time data' do
      @mapper.should contain :time => :value1
    end

    it 'should map to game_time data' do
      @mapper.should contain :game_time => :value2
    end

    it 'should map to game_mode data' do
      @mapper.should contain :game_mode => :value3
    end

    it 'should map to gyroscope data' do
      @mapper.should contain :gyroscope => :value4
    end
  end

  describe 'force resistance data' do
    before(:all) do
      @mapper = mapper_for :FRP => { :lf => :value1, :rf => :value2 }
    end

    it 'should map to left_foot_force' do
      @mapper.should contain :left_foot_resistance => :value1
    end

    it 'should map to right_foot_force' do
      @mapper.should contain :right_foot_resistance => :value2
    end
  end

  describe 'head' do
    before(:all) do
      @mapper = mapper_for :HJ => { :hj1 => { :ax => :value1 }, :hj2 => { :ax => :value2 }}
    end

    it 'should map to h1 data' do
      @mapper.should contain :h1 => :value1
    end

    it 'should map to h2 data' do
      @mapper.should contain :h2 => :value2
    end
  end

  describe 'right arm' do
    before(:all) do
      @mapper = mapper_for :HJ => { :raj1 => { :ax => :value1 },
                                    :raj2 => { :ax => :value2 },
                                    :raj3 => { :ax => :value3 },
                                    :raj4 => { :ax => :value4 }}
    end

    it 'should map to ra1 data' do
      @mapper.should contain :ra1 => :value1
    end

    it 'should map to ra2 data' do
      @mapper.should contain :ra2 => :value2
    end

    it 'should map to ra3 data' do
      @mapper.should contain :ra3 => :value3
    end

    it 'should map to ra4 data' do
      @mapper.should contain :ra4 => :value4
    end
  end

  describe 'left arm' do
    before(:all) do
      @mapper = mapper_for :HJ => { :laj1 => { :ax => :value1 },
                                    :laj2 => { :ax => :value2 },
                                    :laj3 => { :ax => :value3 },
                                    :laj4 => { :ax => :value4 }}
    end

    it 'should map to la1 data' do
      @mapper.should contain :la1 => :value1
    end

    it 'should map to la2 data' do
      @mapper.should contain :la2 => :value2
    end

    it 'should map to la3 data' do
      @mapper.should contain :la3 => :value3
    end

    it 'should map to la4 data' do
      @mapper.should contain :la4 => :value4
    end
  end

  describe 'right leg' do
    before(:all) do
      @mapper = mapper_for :HJ => { :rlj1 => { :ax => :value1 },
                                    :rlj2 => { :ax => :value2 },
                                    :rlj3 => { :ax => :value3 },
                                    :rlj4 => { :ax => :value4 },
                                    :rlj5 => { :ax => :value5 },
                                    :rlj6 => { :ax => :value6 }}
    end

    it 'should map to rl1 data' do
      @mapper.should contain :rl1 => :value1
    end

    it 'should map to rl2 data' do
      @mapper.should contain :rl2 => :value2
    end

    it 'should map to rl3 data' do
      @mapper.should contain :rl3 => :value3
    end

    it 'should map to rl4 data' do
      @mapper.should contain :rl4 => :value4
    end
    
    it 'should map to rl5 data' do
      @mapper.should contain :rl5 => :value5
    end

    it 'should map to rl6 data' do
      @mapper.should contain :rl6 => :value6
    end
  end

  describe 'left leg' do
    before(:all) do
      @mapper = mapper_for :HJ => { :llj1 => { :ax => :value1 },
                                    :llj2 => { :ax => :value2 },
                                    :llj3 => { :ax => :value3 },
                                    :llj4 => { :ax => :value4 },
                                    :llj5 => { :ax => :value5 },
                                    :llj6 => { :ax => :value6 }}
    end

    it 'should map to ll1 data' do
      @mapper.should contain :ll1 => :value1
    end

    it 'should map to ll2 data' do
      @mapper.should contain :ll2 => :value2
    end

    it 'should map to ll3 data' do
      @mapper.should contain :ll3 => :value3
    end

    it 'should map to ll4 data' do
      @mapper.should contain :ll4 => :value4
    end
    
    it 'should map to ll5 data' do
      @mapper.should contain :ll5 => :value5
    end

    it 'should map to ll6 data' do
      @mapper.should contain :ll6 => :value6
    end
  end
end