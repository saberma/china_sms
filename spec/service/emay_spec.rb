# encoding: utf-8
require 'spec_helper'

describe "Emay" do

  describe "#to" do
    let(:username) { 'YOUR_CDKEY' }
    let(:password) { 'YOUR_PASSWORD' }
    let(:url) { "http://sdkhttp.eucp.b2m.cn/sdkproxy/sendsms.action" }
    let(:content) { '测试内容' }
    subject { ChinaSMS::Service::Emay.to phone, content, username: username, password: password }

    describe 'single phone' do
      let(:phone) { '13552241639' }

      before do
        stub_request(:post, url).
          with(body: {cdkey: username, password: password, phone: phone, message: content}).
          to_return(body: '<?xml version="1.0" encoding="UTF-8" ?><error>0</error><message></message></response>')
      end

      its([:success]) { should eql true }
      its([:code]) { should eql '0' }
    end
  end

end
