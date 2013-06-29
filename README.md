# ChinaSMS 短信平台 Ruby 接口

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
