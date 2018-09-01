require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    @map.get(key)
    self.update_node!(@map)
  end

  def to_s
    'Map: ' + @map.to_s + '\n' + 'Store: ' + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
    @map.set(key, @store.last)
  end

  def update_node!(node)
    # suggested helper method; move a node to the end of the list
    key, val = node.key, node.val
    @map.get(key).remove
    @store.append(key, val)
  end

  def eject!
    @map.delete(@store.first)
    @store.remove(@store.first)
  end
end
