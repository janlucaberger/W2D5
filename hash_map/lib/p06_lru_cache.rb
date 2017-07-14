require_relative 'p05_hash_map'
require_relative 'p04_linked_list'
require 'byebug'
class LRUCache
  attr_accessor :count, :map, :store, :prc, :max
  def initialize(max, prc = Proc.new { |x| x ** 2 })
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    map.count
  end

  def get(key)
    if map.include?(key)
      update_link!(map[key])
      return map[key].val
    else
      eject! if count == max
      value = prc.call(key)
      self.store.append(key, value)
      self.map[key] = self.store.last
      value
    end
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
  end

  def update_link!(link)
    key = link.key
    val = link.val
    self.store.remove(key)
    self.store.append(key, val)
    map[key] = store.first
  end

  def eject!
    new_first = store.first.next
    map.delete(store.first.key)
    store.head.next = new_first
    new_first.prev = store.head
  end
end
