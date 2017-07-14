class StaticArray
  def initialize(capacity)
    @store = Array.new(capacity)
  end

  def [](i)
    validate!(i)
    @store[i]
  end

  def []=(i, val)
    validate!(i)
    @store[i] = val
  end

  def length
    @store.length
  end

  def render
    @store
  end

  private

  def validate!(i)
    # puts @store.length
    raise "Overflow error" unless i.between?(0, @store.length - 1)
  end
end

class DynamicArray

  attr_accessor :store, :count, :temp_store

  def initialize(capacity = 8)
    @store = StaticArray.new(capacity)
    @count = 0
    @temp_store = nil
  end

  def [](i)
    self.store[i]
  end

  def []=(i, val)
    self.store[i] = val
  end

  def capacity
    @store.length
  end

  def include?(val)
  end

  def push(val)
    resize! if count == store.length
    self.store[count] = val
    self.count += 1
  end

  # def unshift(val)
  #   resize! if count == store.length
  #   i = 0
  #   next_val = store[0]
  #   while i < self.store.length
  #     self.store[i] = val
  #     i += 1
  #     break if i >= store.length
  #     val = next_val
  #     if i < store.length - 1
  #       next_val = store[i]
  #     end
  #   end
  # end

  def unshift(val)
    temp_store = DynamicArray.new(self.store.length)
      puts "#{temp_store.store.render}"
    temp_store.store[0] = val
      puts "#{temp_store.store.render}"
    i = 1
    while i < count - 1

      temp_store.push(self.store[i])
      puts "#{temp_store.store.render}"

      i += 1
    end
    puts "#{temp_store.store.render}"
  end

  def pop
  end

  def shift
  end

  def first
  end

  def last
  end

  def each(&prc)
    i = 0
    while i < self.store.length
      prc.call(self.store[i])
      i += 1
    end
    self
  end

  def to_s
    "[" + inject([]) { |acc, el| acc << el }.join(", ") + "]"
  end

  def ==(other)
    return false unless [Array, DynamicArray].include?(other.class)
    # ...
  end

  alias_method :<<, :push
  [:length, :size].each { |method| alias_method method, :count }

  private

  def resize!
  end
end
