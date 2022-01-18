require 'date'
require './lib/encrypt'
require './lib/decrypt'

class Enigma
  attr_reader
  attr_accessor


  def encrypt(message, key, date = Time.now.strftime("%d%m%y"))
    Encrypt.new(message, key, date).encrypt
  end

  def decrypt(ciphertext, key, date = Time.now.strftime("%d%m%y"))
    Decrypt.new(ciphertext, key, date).decrypt
  end


end
