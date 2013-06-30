require 'spec_helper'

describe "Tui3" do
  describe "#to" do
    let(:username) { 'saberma' }
    let(:password) { '666666' }
    let(:phone) { '13928452841' }
    let(:content) { '活动通知：深圳 Rubyist 活动时间变更到明天下午 7:00，请留意。' }
    before do
      stub_request(:post, "http://tui3.com/api/send/").
        with(body: {k: password, t: phone, c: content, p: '1', r: 'json'}).
        to_return(body: {
          "err_code"     => 0,
          "err_msg"      => "操作成功！",
          "sms_count"    => 1,
          "tick_ids"     => "20076900",
          "remain_count" => 6,
          "server_time"  => "2013-06-30 22:05:31"
        })
    end
    subject { ChinaSMS::Service::Tui3.to phone, content, username: username, password: password }
    its([:success]) { should eql true }
    its([:code]) { should eql 0 }
    its([:message]) { should eql "操作成功！" }
  end
end
