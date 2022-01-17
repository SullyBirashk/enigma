require 'date'

class Decrypt
  attr_reader :ciphertext, :key, :date
  attr_accessor

  def initialize(ciphertext, key, date)
    @ciphertext = ciphertext
    @key = key
    @date = date
  end


end
