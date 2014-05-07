# encoding: utf-8
module ChinaSMS
  module Service
    module Yunpian
      extend self

      GET_URL      = "http://yunpian.com/v1/user/get.json"
      SEND_URL     = 'http://yunpian.com/v1/sms/send.json'
      TPL_SEND_URL = 'http://yunpian.com/v1/sms/tpl_send.json'

      def to phone, content, options = {}
        options[:tpl_id] ||= 2
        options[:apikey] ||= options[:password]
        except! options, :username, :password

        res = if content.is_a? Hash
                message = parse_content content
                options.merge!({ mobile: phone, tpl_value: message })
                Net::HTTP.post_form(URI.parse(TPL_SEND_URL), options)
              else
                except! options, :tpl_id
                message = content
                options.merge!({ mobile: phone, text: message })
                Net::HTTP.post_form(URI.parse(SEND_URL), options)
              end

        result res.body
      end

      def get options = {}
        options[:apikey] ||= options[:password]
        except! options, :username, :password
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

      def parse_content content
        content.map { |k, v| "##{k}#=#{v}" }.join('&')
      end
    end
  end
end
