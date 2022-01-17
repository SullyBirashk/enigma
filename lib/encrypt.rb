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
    @shift_amount[:first] = (@key_hash[:a].to_i + @offset_hash[:a].to_i)
    @shift_amount[:second] = (@key_hash[:b].to_i + @offset_hash[:b].to_i)
    @shift_amount[:third] = (@key_hash[:c].to_i + @offset_hash[:c].to_i)
    @shift_amount[:fourth] = (@key_hash[:d].to_i + @offset_hash[:d].to_i)


    @shift_amount.each do |key, value|
      until value <= 27 do
        value -= 27
      end
      @shift_amount[key] = value
    end

    return @shift_amount

  end

  def encrypt
    letters = {
      1 => "a",
      2 => "b",
      3 => "c",
      4 => "d",
      5 => "e",
      6 => "f",
      7 => "g",
      8 => "h",
      9 => "i",
      10 => "j",
      11 => "k",
      12 => "l",
      13 => "m",
      14 => "n",
      15 => "o",
      16 => "p",
      17 => "q",
      18 => "r",
      19 => "s",
      20 => "t",
      21 => "u",
      22 => "v",
      23 => "w",
      24 => "x",
      25 => "y",
      26 => "z",
      27 => " "
    }
    reverse_map = letters.invert

    test_message = ["a","b","c","d","e"]
    test_shift = [1,2,3,4]

    return sully_zip(test_shift, test_message)

    # y = []
    #
    # reverse_map = letters.invert
    #
    # test = ["a","b"]
    # test_shift = [3, 4]
    #
    # x = test_shift.zip test # returns [[3, "a"], [4, "b"]]
    #
    # x.each do |shift, let|
    #   current_position = reverse_map[let]
    #   new_position = current_position + shift
    #   y << new_letter = letters[new_position]
    # end
    #
    # return y
  end

  def sully_zip(test_shift, test_message)
    collector = []
    counter = 0
    original_test_shift = test_shift
    test_message.each do |letter|
      position = test_message.find_index(letter)
      if position > 3
        counter = 0
      end
      collector << [test_shift[counter], letter]
      counter += 1
    end
    return collector
  end


end
