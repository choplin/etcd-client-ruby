require 'spec_helper'
require 'etcd'

RSpec.configure do |c|
  c.include EtcdHelper
end

describe Etcd do
  before :all do
    setup_etcd
  end

  after :all do
    teardown_etcd
  end

  it 'can connect to etcd' do
    expect(Etcd.client).to be_an_instance_of Etcd::Client::V2
  end
end
