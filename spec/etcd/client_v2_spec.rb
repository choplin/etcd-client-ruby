require 'spec_helper'

describe Etcd::Client::V2 do
  it 'should have a version number' do
    Etcd::Client::VERSION.should_not be_nil
  end
end
