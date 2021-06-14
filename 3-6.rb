require 'byebug'

puts Integer(10)           # => 10
puts Integer(10.1)         # => 10
puts Integer("0x10")       # => 16
puts Integer("010")        # => 8
puts Integer("0b10")       # => 2

# Time defines #to_i
puts Integer(Time.now)     # => 1341469768

# puts "cccc".to_i
# puts Integer("cccc")


def pretty_int(value)
  decimal = Integer(value).to_s
  # 讓 decimal 的長度為 3 的倍數，leader 為前面多出來的那幾個數字
  leader = decimal.slice!(0, decimal.length % 3)
  # 讓 decimal 每 3 位中間加逗號
  decimal.gsub!(/\d{3}(?!$)/,'\0,')
  decimal = nil if decimal.empty?
  leader = nil if leader.empty?
  [leader,decimal].compact.join(",")
end

puts pretty_int(1000)          # => "1,000"
puts pretty_int(23)            # => "23"
puts pretty_int(4567.8)        # => "4,567"
puts pretty_int("0xCAFE")      # => "51,966"
puts pretty_int(Time.now)      # => "1,341,500,601"


inventory = ['apples', 17, 'oranges', 11, 'pears', 22]
puts Hash[*inventory] # => {"apples"=>17, "oranges"=>11, "pears"=>22}



