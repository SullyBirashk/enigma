require './lib/decrypt'
require 'pry'


RSpec.describe Decrypt do
  before :each do
    @decrypt = Decrypt.new("nekw", "17380", "150122")
  end

  it 'exists' do
    expect(@decrypt).to be_instance_of(Decrypt)
  end

  it 'has a ciphertext' do
    expect(@decrypt.ciphertext).to eq('nekw')
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

  xit 'can assign a - d a number called offset' do
    expect(@decrypt.offset_shift).to eq({a: "4", b: "8", c: "8", d: "4"})
  end

  xit 'can assign a number to a - d to know how many numbers to shift' do
    expect(@decrypt.shift_amount).to eq({first: 21, second: 27, third: 19, fourth: 3})
  end

end
