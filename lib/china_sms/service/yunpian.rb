# encoding: utf-8
module ChinaSMS
  module Service
    module Yunpian
      extend self

      URL = "http://yunpian.com/v1/sms/tpl_send.json"
      GET_URL = "http://yunpian.com/v1/sms/get.json"

      def to phone, content, options = {}
        message = parse_content content, options[:company]
        options[:tpl_id] ||= 2
        options[:apikey] ||= options[:password]
        except! options, :username, :password, :company
        options.merge!({mobile: phone, tpl_value: message})
        res = Net::HTTP.post_form(URI.parse(URL), options)
        result res.body
      end

      def get options = {}
        options[:apikey] ||= options[:password]
        except! options, :username, :password, :company
        res = Net::HTTP.post_form(URI.parse(GET_URL), options)
        result res.body
      end

      def result body
        begin
          JSON.parse body
        rescue => e
          {
            code: 502,
            msg: "内容解析错误",
            detail: e.to_s
          }
        end
      end

      private

      def except! options = {}, *keys
        keys.each {|key| options.delete(key)}
        options
      end

      def parse_content content = '1234', company = '云片网'
        "#code#=#{content}&#company#=#{company}"
      end
    end
  end
end

