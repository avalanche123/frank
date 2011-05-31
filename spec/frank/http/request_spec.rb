require 'spec_helper'

module Frank::HTTP
  describe Request do
    describe "#body" do
      it "sets body for all acceptable methods" do
        ["GET", "POST", "PUT", "DELETE", "HEAD", "PATCH", "OPTIONS"].each do |method|
          request = Request.new(method)
          request.body = 'body'
          request.body.should eq('body')
        end
      end

      it "raises if a trace request contains body" do
        request = Request.new("TRACE")
        expect { request.body = 'body' }.to raise_error(TraceRequestBody)
      end
    end
  end
end