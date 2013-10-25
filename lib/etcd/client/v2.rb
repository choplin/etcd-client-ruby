require 'etcd/client/exception'
require 'etcd/client/helper'
require 'net/http'
require 'json'

module Etcd
  module Client
    class V2
      include Helper

      DEFAULT_PARAM = {consistent: true}

      def initialize(uris, format)
        @uris = uris
        @format = format
        @max_redirection = uris.length
      end

      def get(key, opts={})
        params = {
          recursive: opts[:recursive],
          sorted:    opts[:sorted],
          wait:      opts[:wait],
          wait_index: opts[:wait_index],
        }
        path = build_keys_path(key)
        res = request(:get, path, params)
        format(res)
      end

      def watch(key, opts={})
        get(key, opts.merge({wait:true}))
      end

      def set(key, val, opts={})
        params = {
          value: val,
          ttl: opts[:ttl]
        }
        path = build_keys_path(key)
        res = request(:put, path, params)
        format(res)
      end

      def update
        # TODO
        raise NotImplementedError
      end

      def create
        # TODO
        raise NotImplementedError
      end

      def compare_and_swap
        # TODO
        raise NotImplementedError
      end

      def delete(key, opts={})
        params = {
          recursive: opts[:recursive]
        }
        path = build_keys_path(key)
        res = request(:delete, path, params)
        format(res)
      end

      private

      def request(method, path, params={})
        merged_params = DEFAULT_PARAM.merge(params)

        req = case method
              when :get
                Net::HTTP::Get.new(path + '?' + build_param_str(merged_params))
              when :post
                r = Net::HTTP::Post.new(path)
                r.set_form_data(merged_params)
                r
              when :put
                r = Net::HTTP::Put.new(path)
                r.set_form_data(merged_params)
                r
              when :delete
                r = Net::HTTP::Delete.new(path)
                r.set_form_data(merged_params)
                r
              else
                raise 'unknown method'
              end

        # TODO: choose the leader node
        uri = @uris[0]
        res = fetch(uri, req, @max_redirection)
      end

      def fetch(uri_str, req, limit)
        raise ArgumentError, 'HTTP redirect too deep' if limit == 0

        url = URI.parse(uri_str)
        res = Net::HTTP.start(url.host, url.port) { |http| http.request(req) }
        case res
        when Net::HTTPSuccess
          res
        when Net::HTTPRedirection
          fetch(response['location'], req, limit - 1)
        when Net::HTTPBadRequest
          handle_error(res)
        else
          # TODO: retry in case of http error
          raise NotImplementedError
        end
      end

      def build_keys_path(key)
        "/v2/keys/#{key.gsub(/^\//,'')}"
      end

      def build_param_str(params)
        params.select{|k,v| not v.nil?}.map{|k,v| "#{k}=#{v}"}.join('&')
      end

      def format(res)
        case @format
        when :json
          res.body
        when :raw
          JSON.parse(res.body)
        else
          raise NotImplementedError
        end
      end
    end
  end
end
