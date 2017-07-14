

class Link


  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
  end
end

class LinkedList
  include Enumerable

  attr_accessor :head, :tail

  def initialize
    @head = Link.new
    @tail = Link.new
    head.next = tail
    tail.prev = head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    self.head.next
  end

  def last
    self.tail.prev
  end

  def empty?
    self.head.next == tail
  end

  def get(key)
    node = find_node(key)
    node.val if node
  end

  def include?(key)
    !find_node(key).nil?
  end

  def append(key, val)
    prev_node = self.tail.prev
    next_node = Link.new(key, val)
    prev_node.next = next_node
    next_node.prev = prev_node
    next_node.next = tail
    self.tail.prev = next_node
  end

  def find_node(key)
    current_node = self.head
    until current_node.key == key
      return nil if current_node.next.nil?
      current_node = current_node.next
    end
    current_node
  end

  def update(key, val)
    node = find_node(key)
    node.val = val if node
  end

  def remove(key)
    node = find_node(key)
    node_prev = node.prev
    node_next = node.next
    node_prev.next = node_next
    node_next.prev = node_prev
  end

  def each
    current_node = head.next
    until current_node.next == nil
      yield(current_node)
      current_node = current_node.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
