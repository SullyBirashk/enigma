require './lib/encrypt'
require 'pry'


RSpec.describe Encrypt do
  before :each do
    @encrypt = Encrypt.new("Test", "17380", "150122")
  end

  it 'exists' do
    expect(@encrypt).to be_instance_of(Encrypt)
  end

  it 'has a message' do
    expect(@encrypt.message).to eq("Test")
  end

  it 'has a key' do
    expect(@encrypt.key).to eq("17380")
  end

  it 'has a date' do
    expect(@encrypt.date).to eq("150122")
  end

end
