# encoding: utf-8
require 'spec_helper'

describe "Luosimao" do

  describe "luosimao#to" do
    let(:username) { 'api' }
    let(:password) { 'password' }
    let(:url) { "https://sms-api.luosimao.com/v1/send.json" }
    let(:content) { '【畅友短信测试】深圳 Rubyist 活动时间变更到周六下午 3:00，请留意。【19屋】' }
    subject { ChinaSMS::Service::Luosimao.to phone, content, username: username, password: password }

    describe 'single phone' do
      let(:phone) { '13928935535' }

      before do
        stub_request(:post, "https://#{username}:#{password}@sms-api.luosimao.com/v1/send.json").
          with(:body => {"message"=> content, "mobile"=> phone}).to_return(body: '{"error":0,"msg":"ok"}')
      end

      its([:success]) { should eql true }
      its([:code]) { should eql 0 }
      its([:message]) { should eql "ok" }
    end
  end

end
