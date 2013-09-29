# encoding: utf-8
require "china_sms/version"
require 'net/http'
Dir.glob("#{File.expand_path(File.dirname(__FILE__))}/china_sms/service/*.rb").sort.each do |f|
  require f.match(/(china_sms\/service\/.*)\.rb$/)[0]
end

module ChinaSMS
  extend self

  def username
    @username
  end

  def password
    @password
  end

  def use(service, options)
    @service = ChinaSMS::Service.const_get("#{service.to_s.capitalize}")
    @service.const_set("URL", options[:base_uri]) if options[:base_uri]
    @username = options[:username]
    @password = options[:password]
  end

  def to(receiver, content)
    @service.to receiver, content.strip, username: @username, password: @password if @service
  end

  def get
    @service.get username: @username, password: @password if @service
  end

  def clear
    @service = @username = @password = nil
  end

end
