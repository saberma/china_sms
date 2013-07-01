require 'spec_helper'

describe "Smsbao" do
  describe "#to" do
    let(:username) { 'saberma' }
    let(:password) { '666666' }
    let(:phone) { '13928452841' }
    let(:content) { '深圳 Rubyist 活动时间变更到周日下午 8:00，请留意。【19屋】' }
    before do
      stub_request(:post, "http://api.chanyoo.cn/utf8/interface/send_sms.aspx").
        with(body: {username: username, password: password, receiver: phone, content: content}).
        to_return(body: '<xml><result>50</result><message>执行操作成功</message>')
    end
    subject { ChinaSMS::Service::Chanyoo.to phone, content, username: username, password: password }
    its([:success]) { should eql true }
    its([:code]) { should eql '50' }
    its([:message]) { should eql "执行操作成功" }
  end
end
