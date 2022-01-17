require 'date'
require './lib/encrypt'

class Enigma
  attr_reader
  attr_accessor


  def encrypt(message, key, date = Time.now.strftime("%d%m%y"))
     Encrypt.new(message, key, date).encrypt
  end



end
