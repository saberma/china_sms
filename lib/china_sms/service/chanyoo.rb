module ChinaSMS
  module Service
    module Chanyoo
      extend self
      def to(phone, content)
        url = "http://api.chanyoo.cn/utf8/interface/send_sms.aspx"
        res = Net::HTTP.post_form(URI.parse(url), username: ChinaSMS.username, password: ChinaSMS.password, receiver: phone, content: content)
        result res.body
      end

      def result(body)
        code = body.match(/.+result>(.+)\<\/result/)[1]
        message = body.match(/.+message>(.+)\<\/message/)[1]
        {success: (code.to_i >= 0), code: code, message: message}
      end
    end
  end
end
