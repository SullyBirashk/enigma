require './lib/encrypt'
require 'pry'


RSpec.describe Encrypt do
  before :each do
    @encrypt = Encrypt.new("hello world", "17380", "150122")
  end

  it 'exists' do
    expect(@encrypt).to be_instance_of(Encrypt)
  end

  it 'has a message' do
    expect(@encrypt.message).to eq("hello world")
  end

  it 'has a key' do
    expect(@encrypt.key).to eq("17380")
  end

  it 'has a date' do
    expect(@encrypt.date).to eq("150122")
  end

  it 'can assight a - d a number called key' do
    expect(@encrypt.key_shift).to eq({a: "17", b: "73", c: "38", d: "80"})
  end

  it 'can assign a - d a number called offset' do
    expect(@encrypt.offset_shift).to eq({a: "4", b: "8", c: "8", d: "4"})
  end

  it 'can assign a number to a - d to know how many numbers to shift' do
    expect(@encrypt.shift_amount).to eq({first: 21, second: 27, third: 19, fourth: 3})
  end

  it 'encryt a message' do
    expect(@encrypt.encrypt).to eq({encryption: "nekw", key: "17380", date: "150122"})
  end


end
