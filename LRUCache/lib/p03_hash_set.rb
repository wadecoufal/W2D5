class HashSet
  attr_reader :count, :store

  def initialize(num_buckets = 8)
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
    @store[num.hash % @store.length]
  end

  def num_buckets
    @store.length
  end

  def resize!
    temp_store = HashSet.new(num_buckets * 2)
    
    @store.each do |bucket|
      bucket.each do |el|
        temp_store.insert(el)
      end
    end
    @store = temp_store.store
  end
end
