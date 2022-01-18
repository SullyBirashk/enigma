require 'date'
require './lib/encrypt'
require './lib/decrypt'

class Enigma
  attr_reader
  attr_accessor


  def encrypt(message, key = random_key_generator, date = Time.now.strftime("%d%m%y"))
    Encrypt.new(message, key, date).encrypt
  end

  def decrypt(ciphertext, key = random_key_generator, date = Time.now.strftime("%d%m%y"))
    Decrypt.new(ciphertext, key, date).decrypt
  end

  def random_key_generator
    @collector = []
    until @collector.length == 5 do
      @collector << rand(10)
    end
    return @collector.join
  end


end
