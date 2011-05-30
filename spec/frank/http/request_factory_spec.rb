require 'spec_helper'

module Frank::HTTP
  describe RequestFactory do
    ["GET", "POST", "PUT", "DELETE", "HEAD", "PATCH", "OPTIONS", "TRACE"].each do |method|
      context "when request creation succedes" do
        let (:request) { mock(Request).as_null_object }

        before(:each) do
          Request.should_receive(:new).with(method).and_return(request)
        end

        it "creates request with given method" do
          block = lambda { |r| }
          RequestFactory.create_request(method, &block)
        end

        it "evaluates block on request instance" do
          request.should_receive(:accept).with('text/html').and_return(nil)
          RequestFactory.create_request method, do
            accept 'text/html'
          end
        end
      end
    end

    ["POST", "PUT", "DELETE", "PATCH"].each do |method|
      context "when method is non-safe" do
        it "sets request body to block's returned string" do
          request = RequestFactory.create_request method, do
            'foo=bar&baz=quiz'
          end
          request.body.should eq('foo=bar&baz=quiz')
        end
      end
    end

    it "raises if no block given" do
      expect { RequestFactory.create_request(method) }.to raise_error(ArgumentError)
    end
  
    it "raises if invalid method given" do
      method, block = "UNKNOWN", lambda {|a, b|}
      expect { RequestFactory.create_request(method, &block) }.to raise_error(ArgumentError)
    end
  end
end