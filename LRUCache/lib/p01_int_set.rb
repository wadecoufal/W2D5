require 'byebug'

class MaxIntSet
  def initialize(max)
    @store = Array.new(max, false)
    
  end

  def insert(num)
    @store[num] = true if is_valid?(num)
    true
  end

  def remove(num)
    @store[num] = false
  end

  def include?(num)
    @store[num]
  end

  private

  def is_valid?(num)
    raise "Out of bounds" unless num.between?(0, @store.length)
     true
  end

  def validate!(num)
    
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num] << num
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % @store.length]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count, :store

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    if self.include?(num)
    elsif @count < num_buckets 
      self[num] << num
      @count += 1
    else
      resize!
      insert(num)
    end
  end

  def remove(num)
    @count -= 1 if self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % @store.length]
  end

  def num_buckets
    @store.length
  end

  def resize!
    temp_store = ResizingIntSet.new(num_buckets * 2)
    
    @store.each do |bucket|
      bucket.each do |el|
        temp_store.insert(el)
      end
    end
    @store = temp_store.store
  end
  
end
