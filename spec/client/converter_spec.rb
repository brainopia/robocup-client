require 'lib/client/convertor'

describe Client::Convertor do
  it 'should convert numbers to big endian format' do
    Client::Convertor.pack(42).should == "\000\000\000*"
  end
  
  it 'should convert numbers from big endian format' do
    Client::Convertor.unpack("\000\000\000*").should == 42
  end
end