# class Fixnum
#   # Fixnum#hash already implemented for you
# end

class Array
  def hash
    return "nil".hash if self.empty?
    self.map.with_index {|el,i| el.hash + i.hash}.reduce(:^)
  end
end

class String
  def hash
    self.unpack("B*")[0].to_i^"hello".unpack("B*")[0].to_i
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    self.to_a.sort.hash
    # 0
  end
end
