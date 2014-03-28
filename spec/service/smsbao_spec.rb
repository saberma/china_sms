# encoding: utf-8
require 'spec_helper'

describe "Smsbao" do
  let(:username) { 'saberma' }
  let(:password) { '666666' }
  describe "#to" do
    let(:url) { "http://api.smsbao.com/sms" }
    let(:content) { '【短信宝测试】深圳 Rubyist 活动时间变更到明天下午 7:00，请留意。【19屋】' }
    subject { ChinaSMS::Service::Smsbao.to phone, content, username: username, password: password }

    describe 'single phone' do
      let(:phone) { '13928452841' }

      before do
        stub_request(:post, url).
          with(body: {u: username, p: Digest::MD5.hexdigest(password), m: phone, c: content}).
          to_return(body: '0')
      end

      its([:success]) { should eql true }
      its([:code]) { should eql '0' }
      its([:message]) { should eql "短信发送成功" }
    end

    describe 'multiple phones' do
      let(:phone) { ['13928452841', '13590142385'] }

      before do
        stub_request(:post, url).
          with(body: {u: username, p: Digest::MD5.hexdigest(password), m: phone.join(','), c: content}).
          to_return(body: '0')
      end

      its([:success]) { should eql true }
      its([:code]) { should eql '0' }
      its([:message]) { should eql "短信发送成功" }
    end

  end

  describe "get" do
    let(:remain_url) { "http://www.smsbao.com/query" }
    subject { ChinaSMS::Service::Smsbao.get username: username, password: password }

    describe "remain send count" do
      before do
        stub_request(:post, remain_url).
          with(body: {u: username, p: Digest::MD5.hexdigest(password)}).
          to_return(body: "0\n100,200")
      end

      its([:success]) { should eql true }
      its([:code]) { should eql '0' }
      its([:message]) { should eql '短信发送成功' }
      its([:send]) { should eql 100 }
      its([:remain]) { should eql 200 }
    end
  end
end
