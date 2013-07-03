# encoding: utf-8
require 'spec_helper'

describe "Smsbao" do
  describe "#to" do
    let(:username) { 'saberma' }
    let(:password) { '666666' }
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
end
