require 'spec_helper'

describe Etcd::Client do
  it 'should have a version number' do
    Etcd::Client::VERSION.should_not be_nil
  end
end
