require 'spec_helper'

module Frank::HTTP
  describe Request do
    it "raises if a trace request contains body" do
      request = Request.new("TRACE")
      expect { request.body = 'body' }.to raise_error(TraceRequestBody)
    end
  end
end