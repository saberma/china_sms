# encoding: utf-8
module ChinaSMS
  module Service
    module Emay
      extend self

      SEND_URL = "http://sdkhttp.eucp.b2m.cn/sdkproxy/sendsms.action"
      GET_URL = "http://sdkhttp.eucp.b2m.cn/sdkproxy/getmo.action"

      def to(phone, content, options)
        phones = Array(phone).join(',')
        res = Net::HTTP.post_form(URI.parse(SEND_URL), cdkey: options[:username], password: options[:password], phone: phones, message: content)
        result res.body
      end

      def result(body)
        code = body.match(/.+error>(.+)\<\/error/)[1]
        {
          success: (code.to_i >= 0),
          code: code
        }
      end

      def getmo(options)
        # res = Net::HTTP.post_form(URI.parse(GET_URL), cdkey: options[:username], password: options[:password])
        url = GET_URL + "?cdkey=#{options[:username]}&password=#{options[:password]}"
        res = Net::HTTP.get(URI.parse(url))
        res.body
      end

    end
  end
end
