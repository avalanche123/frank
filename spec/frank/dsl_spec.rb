require 'spec_helper'

module Frank
  describe DSL do
    before(:each) do
      @dsl = Class.new { include Frank::DSL }
    end

    [:get, :post, :put, :delete, :patch,
     :head, :options, :trace, :connect].each do |method|
      describe "##{method}" do
        it "delegates to Frank::HTTP::RequestFactory.create_request" do
          path, block = '/', lambda {}
          Frank::HTTP::RequestFactory.should_receive(:create_request).with(
            method.to_s.upcase, path, &block
          )
          @dsl.__send__ method, path, &block
        end
      end
    end
  end
end