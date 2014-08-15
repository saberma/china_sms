# encoding: utf-8

module ChinaSMS
  module Service
    module Luosimao
      extend self

      URL = "https://sms-api.luosimao.com/v1/send.json"

      def to(phone, content, options)
        url = URI.parse(URL)
        post = Net::HTTP::Post.new(url.path)
        post.basic_auth(options[:username], options[:password])
        post.set_form_data({mobile: phone, message: content})

        socket = Net::HTTP.new(url.host, url.port)
        socket.use_ssl = true
        response = socket.start {|http| http.request(post) }
        result JSON.parse(response.body)
      end

      def result(body)
        {
          success: body['error'] == 0,
          code: body['error'],
          message: body['msg']
        }
      end
    end
  end
end
