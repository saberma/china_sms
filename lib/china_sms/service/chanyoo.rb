# encoding: utf-8
module ChinaSMS
  module Service
    module Chanyoo
      extend self
      URL = "http://api.chanyoo.cn/utf8/interface/send_sms.aspx"
      def to(phone, content, options)
        phones = Array(phone).join(',')
        res = Net::HTTP.post_form(URI.parse(URL), username: options[:username], password: options[:password], receiver: phones, content: content)
        result res.body
      end

      def result(body)
        code = body.match(/.+result>(.+)\<\/result/)[1]
        message = body.match(/.+message>(.+)\<\/message/)[1]
        {
          success: (code.to_i >= 0),
          code: code,
          message: message.force_encoding("UTF-8")
        }
      end
    end
  end
end
