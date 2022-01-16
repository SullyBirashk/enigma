require 'date'

class Encrypt
  attr_reader :message, :key, :date
  attr_accessor

  def initialize(message, key, date)
    @message = message
    @key = key
    @date = date
    @key_hash = Hash.new (0)
  end

  def key_shift
    seperated_key = @key.split('') # Returns ["1", "7", "3", "8", "0"]

    @key_hash[:a] = seperated_key[0] + seperated_key[1]
    @key_hash[:b] = seperated_key[1] + seperated_key[2]
    @key_hash[:c] = seperated_key[2] + seperated_key[3]
    @key_hash[:d] = seperated_key[3] + seperated_key[4]

    return @key_hash
  end


end
