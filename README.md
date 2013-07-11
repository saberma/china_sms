# ChinaSMS 短信平台 Ruby 接口

[![Build Status](https://travis-ci.org/saberma/china_sms.png?branch=master)](https://travis-ci.org/saberma/china_sms)

## 支持以下短信平台

所有短信平台都禁止发送私人短信，并要求在短信内容末尾加上签名后缀，如【19屋】

* [推立方](http://tui3.com/) 专注于注册校验码等实时应用，需要[配置内容格式和签名](http://www.tui3.com/Members/smsconfigv2/)，会自动在短信加上签名后缀。短信计数：移动/联通每条短信的最大长度为64字符，电信每条最大长度60字符（半角、全角各算一个）。超过该长度后，短信后面自动增加分页信息(x/y),此时，每条短信最大长度需要再减3（不超过10页）
* [短信宝](http://www.smsbao.com/)
* [畅友网络](http://www.chanyoo.cn/) 群发短信需要半小时左右的时间审核，星期五等繁忙时段会有几个小时的延时，不适合发送注册校验码等实时短信，单次最多发送500个号码

非常感谢 [推立方](http://tui3.com/) 为 [19屋活动平台](http://19wu.com) 提供短信赞助。

## 安装

加入以下代码到 Gemfile:

    gem 'china_sms'

然后执行:

    $ bundle

或者直接安装：

    $ gem install china_sms

## 使用

```ruby
# 支持 :tui3, :smsbao, chanyoo 短信接口
ChinaSMS.use :tui3, username: 'YOUR_USERNAME', password: 'YOUR_PASSWORD'
ChinaSMS.to '13912345678', '[Test]China SMS gem has been released.'
```

## 安全性

在安全性方面，很多接口都是使用用户登录明文密码，推立方 和 短信宝 要好一些。

* **推立方**，不使用登录密码，而是由系统自动生成一长串 API_KEY，专用于接口调用
* **短信宝**，使用登录密码，但在调用时要先转成 MD5
