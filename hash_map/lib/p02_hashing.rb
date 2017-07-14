require 'byebug'
class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    hsh = []
    self.each_with_index do |num, i|
      hsh << num.hash.to_s[0..4]
    end
    self.length % 2 == 0 ? hsh.join.reverse.to_i : hsh.join.to_i
  end
end

class String
  def hash
    hsh = []
    self.split.each do |ch|
      hsh << ch.unpack("B*")
    end
    hsh.join.to_i
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    hsh = 0
    self.each do |k, v|
      key_hash = k.hash
      val_hash = v.hash
      hsh += key_hash + val_hash
    end
    hsh
  end
end
