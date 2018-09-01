require_relative 'p04_linked_list'

class HashMap
  include Enumerable
  attr_reader :count, :store

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    self.bucket(key).include?(key)
  end

  def set(key, val)
    resize! if @count+1 == num_buckets
    self.delete(key)
    @count += 1
    self.bucket(key).append(key, val) 
  end

  def get(key)
    self.bucket(key).get(key)
  end

  def delete(key)
    if self.bucket(key).remove(key)
      @count -= 1 
    end
  end

  def each(&prc)
    @store.each do |bucket|
      bucket.each do |node|
        prc.call(node.key, node.val)
      end
    end
    self
  end
  
  # uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    temp_store = HashMap.new(num_buckets * 2)
    
    @store.each do |bucket|
      bucket.each do |node|
        temp_store.set(node.key,node.val)
      end
    end
    @store = temp_store.store
  end
  
  public
  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
    @store[key.hash % @store.length]
  end
end
