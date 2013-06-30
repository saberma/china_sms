module ChinaSMS
  module Service
    # http://tui3.com/
    module Tui3
      extend self
      def to(phone, content)
        url = "http://tui3.com/api/send/"
        res = Net::HTTP.post_form(URI.parse(url), k: ChinaSMS.password, t: phone, c: URI::encode(content), p: 1, r: 'json')
        result res.body
        #{"err_code":2,"err_msg":"k,\u975e\u6cd5apikey:666666","server_time":"2013-06-30 20:17:36"}
      end

      def result(json)
        json
      end
    end
  end
end
