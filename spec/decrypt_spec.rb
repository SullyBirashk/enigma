require './lib/decrypt'
require 'pry'


RSpec.describe Decrypt do
  before :each do
    @decrypt = Decrypt.new("Test", 17380, 150122)
  end

  it 'exists' do
    expect(@decrypt).to be_instance_of(Decrypt)
  end

  it 'has a ciphertext' do
    expect(@decrypt.ciphertext).to eq('Test')
  end

end
