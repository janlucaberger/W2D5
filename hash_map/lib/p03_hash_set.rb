require 'byebug'

require_relative 'p02_hashing'
require_relative 'p01_int_set'

# class HashSet
#   attr_accessor :count, :store
#
#   def initialize(num_buckets = 8)
#     @store = Array.new(num_buckets) { Array.new }
#     @count = 0
#   end
#
#   def insert(key)
#     unless include?(key)
#       # debugger
#       resize! if count >= store.length
#       self[key] << key
#       self.count += 1
#     end
#   end
#
#   def include?(key)
#     self[key].include?(key)
#   end
#
#   def remove(key)
#     self[key].delete(key)
#   end
#
#   private
#
#   def [](num)
#     hsh = num.hash
#     bucket_idx = hsh % num_buckets
#     self.store[bucket_idx]
#   end
#
#   def num_buckets
#     @store.length
#   end
#
#   def resize!
#   end
# end

class HashSet < ResizingIntSet
    private

    def [](num)
      hsh = num.hash
      bucket_idx = hsh % num_buckets
      self.store[bucket_idx]
    end
end
