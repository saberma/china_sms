module ChinaSMS
  module Service
    module Smsbao
      extend self
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

      def to(phone, content)
        url = "http://api.smsbao.com/sms?u=#{ChinaSMS.username}&p=#{Digest::MD5.hexdigest(ChinaSMS.password)}&m=#{phone}&c=#{URI::encode(content)}"
        result Net::HTTP.get(URI(url))
      end

      def result(code)
        {success: (code == '0'), code: code, message: self.MESSAGES[body]}
      end
    end
  end
end
