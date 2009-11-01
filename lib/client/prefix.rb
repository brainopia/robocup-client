# convert numbers to and from big endian format
module Client::Prefix
  def self.pack(number)
    [number].pack 'N'
  end

  def self.unpack(big_endian)
    big_endian.unpack('N').first
  end
end