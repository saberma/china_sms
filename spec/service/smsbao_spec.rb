require 'spec_helper'

describe "Smsbao" do
  describe "#to" do
    let(:username) { 'saberma' }
    let(:password) { '666666' }
    let(:phone) { '13928452841' }
    let(:content) { '深圳 Rubyist 活动时间变更到明天下午 7:00，请留意。【19屋】' }
    before do
      stub_request(:post, "http://api.smsbao.com/sms").
        with(body: {u: username, p: Digest::MD5.hexdigest(password), m: phone, c: content}).
        to_return(body: '0')
    end
    subject { ChinaSMS::Service::Smsbao.to phone, content, username: username, password: password }
    its([:success]) { should eql true }
    its([:code]) { should eql '0' }
    its([:message]) { should eql "短信发送成功" }
  end
end
