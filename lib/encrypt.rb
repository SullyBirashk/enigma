require 'date'

class Encrypt
attr_reader :message, :key, :date
attr_accessor

def initialize(message, key, date)
  @message = message
  @key = key
  @date = date
end


end
