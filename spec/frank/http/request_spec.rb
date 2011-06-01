require 'spec_helper'

module Frank::HTTP
  describe Request do
    describe "#body=" do
      it "sets body for all acceptable methods" do
        ["GET", "POST", "PUT", "DELETE", "HEAD", "PATCH", "OPTIONS", "CONNECT"].each do |method|
          request = Request.new(method)
          expect { request.body = 'body' }.to_not raise_error(RequestCannotHaveBodyError)
        end
      end

      it "raises if a trace request contains body" do
        request = Request.new("TRACE")
        expect { request.body = 'body' }.to raise_error(RequestCannotHaveBodyError)
      end
    end

    describe "#method_missing" do
      let(:request) { Request.new("GET") }

      context "when method is like /^(\w+)$/" do
        let(:headers) {
          request.instance_variable_get :@headers
        }

        context "when one value given" do
          it "sets header" do
            request.accept 'text/html'
            headers[:accept].should eq('text/html')
          end
        end

        context "when multiple values given" do
          it "sets header" do
            request.accept 'text/html', 'text/plain'
            headers[:accept].should eq('text/html,text/plain')
          end
        end

        it "raises when no header value is given" do
          expect { request.__send__(:accept) }.to raise_error(ArgumentError)
        end
      end

      context "when method is not like /^(\w+)$/" do
        it "raises NoMethodError" do
          [:unknown=, :unknown?, :unknown!].each do |method|
            expect { request.__send__(method) }.to raise_error(NoMethodError)
          end
        end
      end
    end

    describe "#h" do
      let(:request) { Request.new("GET") }

      it "calls Frank::HTTP::Header#new with header and attributes" do
        Header.should_receive(:new).with('header_value', {:q => 0.9})
        request.h('header_value', {:q => 0.9})
      end

      it "calls Frank::HTTP::Header#new with just header" do
        Header.should_receive(:new).with('header_value', {})
        request.h('header_value')
      end
    end
  end
end