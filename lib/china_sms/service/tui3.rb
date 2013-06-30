module ChinaSMS
  module Service
    # http://tui3.com/
    module Tui3
      extend self
      def to(phone, content, options)
        url = "http://tui3.com/api/send/"
        res = Net::HTTP.post_form(URI.parse(url), k: options[:password], t: phone, c: content, p: 1, r: 'json')
        result res.body
      end

      def result(body)
        {
          success: body['err_code'] == 0,
          code: body['err_code'],
          message: body['err_msg']
        }
      end
    end
  end
end
