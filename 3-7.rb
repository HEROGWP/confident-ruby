puts Array("foo")                  # => ["foo"]
puts Array([1,2,3])                # => [1, 2, 3]
puts Array([])                     # => []
puts Array(nil)                    # => []
puts Array({:a => 1, :b => 2})     # => [[:a, 1], [:b, 2]]
puts Array(1..5)                   # # => [1, 2, 3, 4, 5]

def log_reading(reading_or_readings)
  readings = Array(reading_or_readings)
  readings.each do |reading|
    # A real implementation might send the reading to a log server...
    puts "[READING] %3.2f" % reading.to_f
  end
end

log_reading(3.14)
log_reading([])
log_reading([87.9, 45.8674, 32])
log_reading(nil)




