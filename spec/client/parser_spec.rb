require 'spec/spec_helper'

describe Client::Parser do
  it 'should parse sexps with integer' do
    Client::Parser.run('(a 5)').should == { :a => 5 }
  end

  it 'should parse sexps with float' do
    Client::Parser.run('(c 3.3)').should == { :c => 3.3 }
  end

  it 'should parse sexps with text' do
    Client::Parser.run('(c text)').should == { :c => :text }
  end

  it 'should parse sexps with multiple items' do
    Client::Parser.run('(b 1 2)').should == { :b => [1, 2] }
  end

  it 'should parse sexps in list' do
    Client::Parser.run('(d 1) (e 2)').should == { :d => 1, :e => 2 }
  end

  it 'should parse sexps in list without paying attention to whitespace between' do
    Client::Parser.run('(d 1)(e 2)').should == { :d => 1, :e => 2 }
  end

  it 'should parse nested sexps' do
    Client::Parser.run('(a (b 1))').should == { :a => { :b => 1 }}
  end

  it 'should parse multiple nested sexps' do
    Client::Parser.run('(a (b 1) (c 2))').should == { :a => { :b => 1, :c => 2 }}
  end

  it 'should parse multiple nested sexps without paying attention to whitespace between' do
    Client::Parser.run('(a (b 1)(c 2))').should == { :a => { :b => 1, :c => 2 }}
  end

  it 'should parse deep nested sexps' do
    Client::Parser.run('(a (b (c (d 1))))').should == { :a => { :b => { :c => { :d => 1 }}}}
  end

  it 'should specially parse sexps with n-node' do
    Client::Parser.run('(a (n N) (b value))').should == { :a => { :N => { :b => :value }}}
  end

  it 'should specially parse sexps with n-node and multiple items' do
    Client::Parser.run('(a (n N) (b value1) (c value2))').
      should == { :a => { :N => { :b => :value1, :c => :value2 }}}
  end

  it 'should specially parse same sexps with different n-node' do
    Client::Parser.run('(a (n N1) (b value1)) (a (n N2) (b value2))').
      should == { :a => { :N1 => { :b => :value1 }, :N2 => { :b => :value2 }}}
  end

  it 'should parse complex sexps' do
    Client::Parser.run('(time (now 696.94))(GS (t 0.00) (pm BeforeKickOff))(GYR (n torso) (rt -0.24 3.30 -0.06))').
      should == {:time=>{:now=>696.94}, :GS=>{:t=>0.0, :pm=>:BeforeKickOff}, :GYR=>{:torso=>{:rt=>[-0.24, 3.3, -0.06]}}}
  end
end