require './lib/decrypt'
require 'pry'


RSpec.describe Decrypt do
  before :each do
    @decrypt = Decrypt.new("nekwnekw", "17380", "150122")
    @decrypt.key_shift
    @decrypt.offset_shift
  end

  it 'exists' do
    expect(@decrypt).to be_instance_of(Decrypt)
  end

  it 'has a ciphertext' do
    expect(@decrypt.ciphertext).to eq('nekwnekw')
  end

  it 'has a key' do
    expect(@decrypt.key).to eq("17380")
  end

  it 'has a date' do
    expect(@decrypt.date).to eq("150122")
  end

  it 'can assight a - d a number called key' do
    expect(@decrypt.key_shift).to eq({a: "17", b: "73", c: "38", d: "80"})
  end

  it 'can assign a - d a number called offset' do
    expect(@decrypt.offset_shift).to eq({a: "4", b: "8", c: "8", d: "4"})
  end

  it 'can assign a - d a number called offset' do
    expect(@decrypt.shift_amount).to eq({:first=>21, :fourth=>3, :second=>27, :third=>19})
  end

  it 'decryt a message' do
    expect(@decrypt.decrypt).to eq({decryption: "testtest", key: "17380", date: "150122"})
  end

end
