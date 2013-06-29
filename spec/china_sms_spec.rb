require 'spec_helper'

describe "ChinaSMS" do
  #let(:service) { :smsbao }
  let(:service) { :chanyoo }
  let(:password) { '666666' }
  subject { ChinaSMS }
  before { ChinaSMS.use service, username: 'saberma', password: password }
  describe "#use" do
    its(:username) { should eql "saberma"}
  end
  describe "#to" do
    it 'should be success' do
      result = subject.to('13928452841', '深圳 Rubyist 活动时间变更到明天下午 7:00，请留意。【19屋】')
      puts result
    end
  end
end
