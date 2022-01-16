require './lib/encrypt'
require 'pry'


RSpec.describe Encrypt do
  before :each do
    @encrypt = Encrypt.new("Test", 17380, 150122)
  end

  it 'exists' do
    expect(@encrypt).to be_instance_of(Encrypt)
  end

end
