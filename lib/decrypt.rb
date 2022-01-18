require 'date'

class Decrypt
  attr_reader :ciphertext, :key, :date
  attr_accessor

  def initialize(ciphertext, key, date)
    @ciphertext = ciphertext
    @key = key
    @date = date
    @key_hash = Hash.new (0)
    @offset_hash = Hash.new (0)
    @shift_amount = Hash.new (0)
    @decrypted_hash = Hash.new(0)
    key_shift
    offset_shift
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

  def decrypt
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

    seperated_decrypted_message = []

    message_split = @ciphertext.downcase.split("") # Returns ["n", "e", "k", "w"]
    rotate_amount = @shift_amount.values

    reverse_map = letters.invert

    decrypted_message_array = custom_zip(rotate_amount, message_split) # [[21, "n"], [27, "e"], [19, "k"], [3, "w"]]

    decrypted_message_array.each do |shift, let| # [[21, "n"], [27, "e"], [19, "k"], [3, "w"]]
      current_position = reverse_map[let]
      new_position = current_position - shift
        if new_position > 27
          until new_position <= 27 do
            new_position -= 27
          end
        elsif new_position < 0
          new_position = 27 - new_position.abs
        end
      seperated_decrypted_message << new_letter = letters[new_position]
    end

    decrypted_message = seperated_decrypted_message.join

    @decrypted_hash[:decryption] = decrypted_message
    @decrypted_hash[:key] = @key
    @decrypted_hash[:date] = @date

    return @decrypted_hash

  end

  def custom_zip(shift_amount, message)
    collector = []
    counter = 0
    message.each_with_index do |letter, index|
      if index%4 == 0
        counter = 0
      end
      collector << [shift_amount[counter], letter]
      counter += 1
    end
    return collector
  end


end
