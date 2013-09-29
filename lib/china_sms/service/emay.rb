# encoding: utf-8
module ChinaSMS
  module Service
    module Emay
      extend self
      URL = "http://sdkhttp.eucp.b2m.cn/sdkproxy"

      def to(phone, content, options)
        phones = Array(phone).join(',')
        res = Net::HTTP.post_form(URI.parse("#{URL}/sendsms.action"), cdkey: options[:username], password: options[:password], phone: phones, message: content)
        result res.body
      end

      def get(options)
        # res = Net::HTTP.post_form(URI.parse(GET_URL), cdkey: options[:username], password: options[:password])
        url = "#{URL}/getmo.action?cdkey=#{options[:username]}&password=#{options[:password]}"
        res = Net::HTTP.get(URI.parse(url))
        res.body
      end

      def result(body)
        code = body.match(/.+error>(.+)\<\/error/)[1]
        {
          success: (code.to_i >= 0),
          code: code
        }
      end

    end
  end
end
