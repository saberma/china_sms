# encoding: utf-8
module ChinaSMS
  module Service
    module Smsbao
      extend self

      URL = "http://api.smsbao.com/sms"
      REMAIN_URL = "http://www.smsbao.com/query"

      MESSAGES = {
        '0'  => '短信发送成功',
        '30' => '密码错误',
        '40' => '账号不存在',
        '41' => '余额不足',
        '42' => '帐号过期',
        '43' => 'IP地址限制',
        '50' => '内容含有敏感词',
        '51' => '手机号码不正确'
      }

      def to(phone, content, options)
        phones = Array(phone).join(',')
        res = Net::HTTP.post_form(URI.parse(URL), u: options[:username], p: Digest::MD5.hexdigest(options[:password]), m: phones, c: content)
        result res.body
      end

      def get options
        res = Net::HTTP.post_form(URI.parse(REMAIN_URL), u: options[:username], p: Digest::MD5.hexdigest(options[:password]))
        r = res.body.match(/(\d+)\n(\d+),(\d+)/)
        {
          success: (r[1] == '0'),
          code: r[1],
          message: MESSAGES[r[1]],
          send: r[2].to_i,
          remain: r[3].to_i
        }
      end

      def result(code)
        {
          success: (code == '0'),
          code: code,
          message: MESSAGES[code]
        }
      end

    end
  end
end
