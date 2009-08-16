require 'lib/client/prefix'

describe Client::Prefix do
  it 'should convert numbers to big endian format' do
    Client::Prefix.pack(42).should == "\000\000\000*"
  end
  
  it 'should convert numbers from big endian format' do
    Client::Prefix.unpack("\000\000\000*").should == 42
  end
end