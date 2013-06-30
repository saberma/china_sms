# ChinaSMS 短信平台 Ruby 接口

## 支持以下短信平台

所有短信平台都禁止发送私人短信，并要求在短信内容末尾加上签名后缀，如【19屋】

* [推立方](http://tui3.com/) 需要审核内容格式和签名，自动在短信加上签名后缀
* [短信宝](http://www.smsbao.com/)
* [畅友网络](http://www.chanyoo.cn/)

## 安装

加入以下代码到 Gemfile:

  gem 'china_sms'

然后执行:

  $ bundle

或者直接安装：

  $ gem install china_sms

## 使用

```ruby
ChinaSMS.use :smsbao, username: 'YOUR_USERNAME', password: 'YOUR_PASSWORD'
ChinaSMS.to '13912345678', '[Test]China SMS gem has been released.'
```
