require 'etcd/client/v2'

module Etcd
  DEFAULT_URI = 'http://localhost:4001'
  DEFAULT_PORT = 4001
  DEFAULT_API_VERSION = 2
  DEFAULT_FORMAT = :raw

  def self.client(opts={})
    uris = opts[:uris] || DEFAULT_URI
    version = opts[:version] || DEFAULT_API_VERSION
    format = opts[:format] || DEFAULT_FORMAT

    uris = [uris] unless uris.class == Array

    case version
    when 2
      Etcd::Client::V2.new(uris, format)
    else
      raise ArgumentError, "unsupported etcd api version: #{version}."
    end
  end
end
