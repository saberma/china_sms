# encoding: utf-8
require 'spec_helper'

describe "Chanyoo" do
  describe "#to" do
    let(:username) { 'saberma' }
    let(:password) { '666666' }
    let(:url) { "http://api.chanyoo.cn/utf8/interface/send_sms.aspx" }
    let(:content) { '【畅友短信测试】深圳 Rubyist 活动时间变更到周六下午 3:00，请留意。【19屋】' }
    subject { ChinaSMS::Service::Chanyoo.to phone, content, username: username, password: password }
    describe 'single phone' do
      let(:phone) { '13928452841' }
      before do
        stub_request(:post, url).
          with(body: {username: username, password: password, receiver: phone, content: content}).
          to_return(body: '<?xml version="1.0" encoding="utf-8" ?><response><result>50</result><message>短信发送成功</message></response>')
      end
      its([:success]) { should eql true }
      its([:code]) { should eql '50' }
      its([:message]) { should eql "短信发送成功" }
    end

    describe 'multiple phones' do
      let(:phone) { ['13928452841', '13590142385'] }
      before do
        stub_request(:post, url).
          with(body: {username: username, password: password, receiver: phone.join(','), content: content}).
          to_return(body: '<?xml version="1.0" encoding="utf-8" ?><response><result>50</result><message>短信发送成功</message></response>')
      end
      its([:success]) { should eql true }
      its([:code]) { should eql '50' }
      its([:message]) { should eql "短信发送成功" }
    end
  end
end
