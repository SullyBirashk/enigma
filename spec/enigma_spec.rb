require './lib/enigma'
require 'pry'


RSpec.describe Enigma do
  before :each do
    @enigma = Enigma.new
    @encrypted = @enigma.encrypt("hello world", "02715")
  end

  it 'exists' do
    expect(@enigma).to be_instance_of(Enigma)
  end

  it 'can encrypt a message' do
    expected = {encryption: "keder ohulw", key: "02715", date: "040895"}

    expect(@enigma.encrypt("hello world", "02715", "040895")).to eq(expected)
  end

  it 'can decrypt a message' do
    expected = {decryption: "helloworld", key: "02715", date: "040895"}

    expect(@enigma.decrypt("keder ohulw", "02715", "040895")).to eq(expected)
  end

  it 'can encrypt a message without a date' do
    expect(@encrypted).to eq({:date=>"170122", :encryption=>"nmjduhugxtb", :key=>"02715"})
  end

  it 'can decrypt a message without a date' do
    expect(@enigma.decrypt(@encrypted[:encryption], "02715")).to eq({:date=>"170122", :decryption=>"helloworld", :key=>"02715"})
  end

  it 'can generate a random key' do
    expect(@enigma.random_key_generator.count).to eq(5)
  end

end
