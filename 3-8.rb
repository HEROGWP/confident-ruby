require 'byebug'

module M1
  def self.foo; end
  def goo; end
end

M1.foo
M1.goo
M1.methods(false)           #=> [:foo]
M1.instance_methods         #=> []
M1.private_instance_methods #=> []

module M2
  module_function

  def goo; end
end

M2.goo
M2.methods(false)           #=> [:goo]
M2.instance_methods         #=> []
M2.private_instance_methods #=> [:goo]

# 總結: module_function = private + extend self 的效果


######### 我是分隔線 ##########

module Graphics
  module Conversions
    module_function

    def Point(*args)
      case args.first
      when Point then args.first
      when Array then Point.new(*args.first)
      when Integer then Point.new(*args)
      when String then
        Point.new(*args.first.split(':').map(&:to_i))
      else
        raise TypeError, "Cannot convert #{args.inspect} to Point"
      end
    end
  end

  Point = Struct.new(:x, :y) do
    def inspect
      "#{x}:#{y}"
    end
  end
end

include Graphics
include Graphics::Conversions

puts Point(Point.new(2,3))    # => 2:3
puts Point([9,7])             # => 9:7
puts Point(3,5)               # => 3:5
puts Point("8:10")            # => 8:10


######### 我是分隔線 ##########

def Point(*args)
  case args.first
  when Integer then Point.new(*args)
  when String then Point.new(*args.first.split(':').map(&:to_i))
  when ->(arg){ arg.respond_to?(:to_point) }
     args.first.to_point
  when ->(arg){ arg.respond_to?(:to_ary) }
    Point.new(*args.first.to_ary)
  else
    raise TypeError, "Cannot convert #{args.inspect} to Point"
  end
end


# Point class now defines #to_point itself
Point = Struct.new(:x, :y) do
  def inspect
  "#{x}:#{y}"
  end

  def to_point
    self
  end
end

# A Pair class which can be converted to an Array
Pair = Struct.new(:a, :b) do
  def to_ary
    [a, b]
  end
end

# A class which can convert itself to Point
class Flag
  def initialize(x, y, flag_color)
    @x, @y, @flag_color = x, y, flag_color
  end
  def to_point
    Point.new(@x, @y)
  end
end

puts Point([5,7])                    # => 5:7
puts Point(Pair.new(23, 32))         # => 23:32
puts Point(Flag.new(42, 24, :red))   # => 42:24



