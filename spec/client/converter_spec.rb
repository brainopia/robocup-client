require 'lib/client/converter'

describe Client::Converter do
  it 'should convert numbers to big endian format' do
    Client::Converter.pack(42).should == "\000\000\000*"
  end
  
  it 'should convert numbers from big endian format' do
    Client::Converter.unpack("\000\000\000*").should == 42
  end
end