require 'date'
require 'pry'

class Encrypt
  attr_reader :message, :key, :date, :key_hash
  attr_accessor

  def initialize(message, key, date)
    @message = message
    @key = key
    @date = date
    @key_hash = Hash.new (0)
    @offset_hash = Hash.new (0)
    @shift_amount = Hash.new (0)
  end

  def key_shift
    seperated_key = @key.split('') # Returns ["1", "7", "3", "8", "0"]

    @key_hash[:a] = seperated_key[0] + seperated_key[1]
    @key_hash[:b] = seperated_key[1] + seperated_key[2]
    @key_hash[:c] = seperated_key[2] + seperated_key[3]
    @key_hash[:d] = seperated_key[3] + seperated_key[4]

    return @key_hash
  end

  def offset_shift
    date_squared = (@date.to_i * @date.to_i).to_s.split('') # Returns ["2", "2", "5", "3", "6", "6", "1", "4", "8", "8", "4"]

    @offset_hash[:d] = date_squared.last
    date_squared.pop
    @offset_hash[:c] = date_squared.last
    date_squared.pop
    @offset_hash[:b] = date_squared.last
    date_squared.pop
    @offset_hash[:a] = date_squared.last

    return @offset_hash
  end

  def shift_amount
    @shift_amount[:a] = (@key_hash[:a].to_i + @offset_hash[:a].to_i)
    @shift_amount[:b] = (@key_hash[:b].to_i + @offset_hash[:b].to_i)
    @shift_amount[:c] = (@key_hash[:c].to_i + @offset_hash[:c].to_i)
    @shift_amount[:d] = (@key_hash[:d].to_i + @offset_hash[:d].to_i)


    @shift_amount.each do |key, value|
      until value <= 27 do
        value -= 27
      end
      @shift_amount[key] = value
    end

    return @shift_amount

  end

  def encrypt
    
  end


end
