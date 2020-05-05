require 'spec_helper'

describe Mongo::GssapiNative::Error do
  it 'can be instantiated' do
    described_class.new.should be_a(described_class)
  end
end
