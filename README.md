# ChinaSMS 短信平台 Ruby 接口

[![Build Status](https://travis-ci.org/saberma/china_sms.png?branch=master)](https://travis-ci.org/saberma/china_sms)

## 支持以下短信平台

所有短信平台都禁止发送私人短信，并要求在短信内容末尾加上签名后缀，如【19屋】

* [云片网](http://www.yunpian.com/) 专注于帮助企业与客户更好的沟通, 提供短信服务, 功能强大, 可以配置多种[模板](http://www.yunpian.com/api/tpl.html), 实时性高, 定制型强, 价格优惠.
* [推立方](http://tui3.com/) 专注于注册校验码等实时应用，需要[配置内容格式和签名](http://www.tui3.com/Members/smsconfigv2/)，会自动在短信加上签名后缀。短信计数：移动/联通每条短信的最大长度为64字符，电信每条最大长度60字符（半角、全角各算一个）。超过该长度后，短信后面自动增加分页信息(x/y),此时，每条短信最大长度需要再减3（不超过10页）
* [短信宝](http://www.smsbao.com/)
* [畅友网络](http://www.chanyoo.cn/) 群发短信需要半小时左右的时间审核，星期五等繁忙时段会有几个小时的延时，不适合发送注册校验码等实时短信，单次最多发送500个号码
* [亿美软通](http://www.emay.cn/)
* [螺丝帽](http://luosimao.com/)

感谢 [云片网](http://yunpian.com/?ref=china_sms) 为 [19屋活动平台](http://19wu.com) 提供短信赞助。

## 安装

加入以下代码到 Gemfile:

    gem 'china_sms'

然后执行:

    $ bundle

或者直接安装：

    $ gem install china_sms

## 使用

```ruby
# 支持 :tui3, :yunpian, :smsbao, :chanyoo, :emay, luosimao  短信接口
ChinaSMS.use :tui3, username: 'YOUR_USERNAME', password: 'YOUR_PASSWORD'
ChinaSMS.to '13912345678', '[Test]China SMS gem has been released.'


# :yunpian
#   如果content(第二个参数) 是字符串
#     调用 通用接口 发送短信
#   如果是 Hash
#     调用 模板接口 发送短信
#     可选参数：
#       :tpl_id 默认是 2

ChinaSMS.use :yunpian, password: 'YOUR_API_KEY'

# 通用接口
ChinaSMS.to '13912345678', '[Test]China SMS gem has been released.'
ChinaSMS.to '13912345678', 'China SMS gem has been released.【Test】'    # luosimao 的签名要放在后面

# 模板接口
# 模板是 "您的验证码是#code#【#company#】”
tpl_params = { code: 123, company: '19wu' }
ChinaSMS.to '13912345678', tpl_params, tpl_id: 1

```

## 贡献

```bash
git clone git@github.com:saberma/china_sms.git
cd china_sms
bundle console # 请不要使用 irb，可能会有依赖问题
```

## TODO

* 签名作为参数，根据各个服务提供商的不同来确定放在内容前面还是后面，例如 luosimao 要求放在内容后面

## 安全性

在安全性方面，很多接口都是使用用户登录明文密码，而云片网、螺丝帽、推立方 和 短信宝 要好一些。

* **云片网**，使用HTTPS，API使用独立的apikey，不使用登录名和密码，支持 IP 白名单
* **推立方**，不使用登录密码，而是由系统自动生成一长串 API_KEY，专用于接口调用
* **短信宝**，使用登录密码，但在调用时要先转成 MD5
* **螺丝帽**，使用HTTPS，登录密码
