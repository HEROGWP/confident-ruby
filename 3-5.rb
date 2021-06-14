require 'byebug'

Account = Struct.new(:first_name, :last_name, :email_address)

class User
  def initialize(account)
    @account = account
  end

  def first_name
    @account.first_name
  end

  def last_name
    @account.last_name
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def email_address
    @account.email_address
  end
end

######### 我是分隔線 ##########

require 'forwardable'

class User
  extend Forwardable

  def_delegators :@account, :first_name, :last_name, :email_address

  def initialize(account)
    @account = account
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end

######### 我是分隔線 ##########

def report_altitude_change(current_altitude, previous_altitude)
  change = current_altitude - previous_altitude
  # ...
end

require 'forwardable'

class Meters
  extend Forwardable

  def_delegators :@value, :to_s, :to_int, :to_i

  def initialize(value)
    @value = value
  end

  def -(other)
    self.class.new(value - other.value)
  end
  # ...
  protected

  attr_reader :value
end

######### 我是分隔線 ##########

def report_altitude_change(current_altitude, previous_altitude)
  change = current_altitude.to_meters - previous_altitude.to_meters
  # ...
end

require 'forwardable'

class Meters
  extend Forwardable

  attr_reader :value

  def_delegators :@value, :to_s, :to_int, :to_i

  def initialize(value)
    @value = value
  end

  def to_meters
    self
  end

  def -(other)
    self.class.new(value - other.to_meters.value)
  end
end

class Feet
  extend Forwardable

  attr_reader :value

  def_delegators :@value, :to_s, :to_int, :to_i

  def initialize(value)
    @value = value
  end

  def to_meters
    Meters.new(value * 0.3048)
  end
end

change = report_altitude_change(Meters.new(1), Feet.new(1))
puts change.value
