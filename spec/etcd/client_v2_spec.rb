require 'spec_helper'
require 'etcd/client/v2'

RSpec.configure do |c|
  c.include EtcdHelper
end

describe Etcd::Client::V2 do
  before :all do
    setup_etcd
    @key = '/test/key'
    @value = 'value'
    @client = Etcd::Client::V2.new(['http://localhost:4001/'], :raw)
  end

  before :each do
    begin
      @client.get('/test')
      @client.delete('/test', :recursive => true)
    rescue  Etcd::Client::KeyNotFoundError
    end
  end

  after :all do
    teardown_etcd
  end

  it 'can set a value with key' do
    res = @client.set(@key, @value)
    expect(res).to include('key' => @key)
  end

  it 'throws KeyNotFoundError for keys which does not exists' do
    expect { @client.get(@key) }.to raise_error Etcd::Client::KeyNotFoundError
  end

  context 'after set a key and a value' do
    before :each do
      @client.set(@key, @value)
    end

    it 'cat get a value' do
      res = @client.get(@key)
      expect(res).to include('value' => @value)
    end

    it 'cat delete a value' do
      @client.delete(@key)
      expect { @client.get(@key) }.to raise_error Etcd::Client::KeyNotFoundError
    end

    it 'cat delete a directory recursively' do
      parent = File.dirname(@key)
      @client.delete(parent, :recursive => true)
      expect { @client.get(parent) }.to raise_error Etcd::Client::KeyNotFoundError
    end
  end
end
