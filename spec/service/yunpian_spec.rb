# encoding: utf-8
require 'spec_helper'

describe "Yunpian" do
  describe "#to" do
    let(:apikey) { '2022b1599967a8cb788c05ddd9fc339e' }
    let(:send_url) { 'https://sms.yunpian.com/v2/sms/batch_send.json' }
    let(:tpl_send_url) { 'https://sms.yunpian.com/v2/sms/tpl_batch_send.json' }
    let(:content) { '云片测试：验证码 1234。' }
    let(:tpl_content) { Hash[:code, 123, :company, '云片网'] }

    describe 'single phone' do
      let(:phone) { '13928452841' }

      before do
        stub_request(:post, tpl_send_url).
          with(
            body: {
              "apikey" => apikey,
              "mobile" => phone,
              "tpl_id" => "2",
              "tpl_value" => "#code#=123&#company#=云片网" },
            headers: {
              'Content-Type' => 'application/x-www-form-urlencoded'
            }).
          to_return(
            body: {
              'code' => 0,
              'msg' => 'OK',
              'result' => {
                'count' => '1',
                'fee' => '1',
                'sid' => '592762800'
              }
            }.to_json
          )

        stub_request(:post, send_url).
          with(
            body: {
              "apikey" => apikey,
              "mobile" => phone,
              "text" => content },
            headers: {
              'Content-Type' => 'application/x-www-form-urlencoded'
            }).
          to_return(
            body: {
              'code' => 0,
              'msg' => 'OK',
              'result' => {
                'count' => '1',
                'fee' => '1',
                'sid' => '592762800'
              }
            }.to_json
          )
      end

      context 'string content' do
        subject { ChinaSMS::Service::Yunpian.to phone, content, password: apikey }

        its(["code"]) { should eql 0 }
        its(["msg"]) { should eql "OK" }
      end

      context 'tpl content' do
        subject { ChinaSMS::Service::Yunpian.to phone, tpl_content, password: apikey }

        its(["code"]) { should eql 0 }
        its(["msg"]) { should eql "OK" }
      end
    end

    describe 'invalid key' do
      let(:phone) { '13928452841' }
      let(:apikey) { '666666' }

      before do
        stub_request(:post, tpl_send_url).
          with(
            body: {
              "apikey"    => apikey,
              "mobile"    => phone,
              "tpl_id"    => "2",
              "tpl_value" => "#code#=123&#company#=云片网" },
            headers: {
              'Content-Type' => 'application/x-www-form-urlencoded'
            }).
          to_return(
            body: {
              "code"   => -1,
              "msg"    => "非法的apikey",
              "detail" => "请检查的apikey是否正确"
            }.to_json
          )

        stub_request(:post, send_url).
          with(
            body: {
              "apikey" => apikey,
              "mobile" => phone,
              "text" => content },
            headers: {
              'Content-Type' => 'application/x-www-form-urlencoded'
            }).
          to_return(
            body: {
              "code"   => -1,
              "msg"    => "非法的apikey",
              "detail" => "请检查的apikey是否正确"
            }.to_json
          )
      end

      context 'string content' do
        subject { ChinaSMS::Service::Yunpian.to phone, content, password: apikey }

        its(["code"]) { should eql -1 }
        its(["msg"]) { should eql "非法的apikey" }
        its(["detail"]) { should eql "请检查的apikey是否正确" }
      end

      context 'tpl content' do
        subject { ChinaSMS::Service::Yunpian.to phone, tpl_content, password: apikey }

        its(["code"]) { should eql -1 }
        its(["msg"]) { should eql "非法的apikey" }
        its(["detail"]) { should eql "请检查的apikey是否正确" }
      end
    end
  end

  describe '#voice_to' do
    let(:apikey) { '2022b1599967a8cb788c05ddd9fc339e' }
    let(:voice_send_url) { 'https://voice.yunpian.com/v2/voice/send.json' }
    let(:content) { '8888' }
    let(:phone) { '13928452841' }
    subject { ChinaSMS::Service::Yunpian.voice_to phone, content, password: apikey }

    before do
      stub_request(:post, voice_send_url).
        with(
          body: {
            "apikey" => apikey,
            "mobile" => phone,
            "code" => content},
          headers: {
            'Content-Type' => 'application/x-www-form-urlencoded'
          }).
        to_return(
          body: {
            'code' => 0,
            'msg' => 'OK',
            'result' => {
              'count' => '1',
              'fee' => '1',
              'sid' => '592762800'
            }
          }.to_json
        )
    end

    its(["code"]) { should eql 0 }
    its(["msg"]) { should eql "OK" }
  end
end
