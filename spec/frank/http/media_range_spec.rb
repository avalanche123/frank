require 'spec_helper'

module Frank::HTTP
  describe MediaRange do
    describe "#to_s" do
      context "when no attributes given" do
        it "gets header value" do
          header = MediaRange.new('text/html')
          header.to_s.should eq('text/html')
        end
      end

      context "when one attribute given" do
        it "gets header value with one attribute" do
          header = MediaRange.new('text/html', :q => 0.9)
          header.to_s.should eq('text/html;q=0.9')
        end
      end

      context "when many attributes given" do
        it "gets header value with multiple attributes" do
          header = MediaRange.new('text/html', :q => 0.9, :foo => :bar)
          header.to_s.should eq('text/html;q=0.9;foo=bar')
        end
      end
    end
  end
end