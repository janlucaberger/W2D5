class MaxIntSet

  attr_reader :max, :store

  def initialize(max)
    @store = Array.new(max) { false }
    @max = max
  end

  def insert(num)
    raise "Out of bounds" if num >= self.max || num < 0
    self.store[num] = true
  end

  def remove(num)
    raise "Number does not exist in this set" if num >= self.max
    self.store[num] = false
  end

  def include?(num)
    self.store[num]
  end

  private

  def is_valid?(num)
  end

  def validate!(num)
  end
end


class IntSet

  attr_reader :store

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num] << num
  end

  def remove(num)
    raise "Does not include number" unless include?(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    bucket_idx = num % num_buckets
    self.store[bucket_idx]
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_accessor :count, :store

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    unless include?(num)
      resize! if count >= store.length
      self[num] << num
      self.count += 1
    end
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    bucket_idx = num % num_buckets
    self.store[bucket_idx]
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    items = store.flatten
    self.store = Array.new(count * 2) { Array.new }
    self.count = 0
    items.each { |item| insert(item) }
  end
end
