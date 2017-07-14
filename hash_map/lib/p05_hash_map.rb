require_relative 'p02_hashing'
require_relative 'p04_linked_list'
require 'byebug'

class HashMap
  include Enumerable
  attr_accessor :store, :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    list = bucket(key)
    list.include?(key)
  end

  def set(key, val)
    resize! if count == store.length
    list = bucket(key)
    if list.include?(key)
      list.update(key, val)
    else
      list.append(key, val)
      self.count += 1
    end
  end

  def get(key)
    list = bucket(key)
    list.get(key)
  end

  def delete(key)
    list = bucket(key)
    list.remove(key)
    self.count -= 1
  end

  def each
    self.store.each do |bucket|
      bucket.each do |node|
        yield(node.key, node.val)
      end
    end
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
    old_store = self.dup
    self.store = Array.new(count * 2) { LinkedList.new }
    self.count = 0
    old_store.each { |key, val| set(key, val) }
  end

  def bucket(key)
    hsh = key.hash
    bucket_idx = hsh % num_buckets
    self.store[bucket_idx]
  end
end
