# encoding: utf-8
require 'json'

module ChinaSMS
  module Service
    module Tui3 # http://tui3.com/
      extend self
      URL = "http://tui3.com/api/send/"
      def to(phone, content, options)
        phones = Array(phone).join(',')
        res = Net::HTTP.post_form(URI.parse(URL), k: options[:password], t: phones, c: content, p: 1, r: 'json')
        result JSON[res.body]
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
