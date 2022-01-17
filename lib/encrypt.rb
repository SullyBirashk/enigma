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
    @encrypted_hash = Hash.new(0)
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

    shift_amount
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
    # reverse_map = letters.invert
    #
    # message_split = @message.downcase.split("") # Returns ["t", "e", "s", "t"]
    # rotate_amount = @shift_amount.values # Returns [21, 27, 19, 3]
    # # rotate_amount is always 4 numbers
    #
    #
    # letter_and_shift_amount = sully_zip(@shift_amount.values, message_split) # Returns [[21, "t"], [27, "e"], [19, "s"], [3, "t"]]
    #
    # @letter_position = [] # Returns [20, 5, 19, 20]
    # message_split.each do |letter|
    #   let_pos = reverse_map[letter]
    #   @letter_position << let_pos
    # end
    #
    # shifted_letter_position = [] # Returns [41, 32, 38, 23]
    # rotate_amount.each do |shift|
    #   shifted_letter_position << (shift + @letter_position[0])
    #   @letter_position.shift
    # end
    #
    # simple_shift_position = [] # Returns [14, 5, 11, 23]
    # shifted_letter_position.each do |shift_pos|
    #   until shift_pos <= 27 do
    #      shift_pos -= 27
    #   end
    #   simple_shift_position << shift_pos
    # end
    #
    # seperated_encrypted_message = [] # Returns ["n", "e", "k", "w"]
    # simple_shift_position.each do |let_pos|
    #   seperated_encrypted_message << letters[let_pos]
    # end
    #
    # encrypted_message = seperated_encrypted_message.join # Returns "nekw"
    #
    # @encrypted_hash[:encryption] = encrypted_message
    # @encrypted_hash[:key] = @key
    # @encrypted_hash[:date] = @date
    #
    # return @encrypted_hash


    seperated_encrypted_message = []

    message_split = @message.downcase.split("") # Returns ["t", "e", "s", "t"]
    rotate_amount = @shift_amount.values # Returns [21, 27, 19, 3]

    reverse_map = letters.invert

    encrypted_message_array = rotate_amount.zip message_split # [[21, "t"], [27, "e"], [19, "s"], [3, "t"]]

    encrypted_message_array.each do |shift, let|
      current_position = reverse_map[let]
      new_position = current_position + shift
        if new_position > 27
          until new_position <= 27 do
            new_position -= 27
          end
        end
      seperated_encrypted_message << new_letter = letters[new_position]
    end

    encrypted_message = seperated_encrypted_message.join

    @encrypted_hash[:encryption] = encrypted_message
    @encrypted_hash[:key] = @key
    @encrypted_hash[:date] = @date

    return @encrypted_hash

  end

  # message_split = @message.downcase.split("") # Returns ["t", "e", "s", "t"]
  # rotate_amount = @shift_amount.values # Returns [21, 27, 19, 3]

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
