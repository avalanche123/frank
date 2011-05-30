module Frank
  module DSL
    [:get, :post, :put, :delete, :patch,
     :head, :options, :trace, :connect].each do |method|
      define_method method do |&block|
        Frank::HTTP::RequestFactory.create_request(method.to_s.upcase, &block)
      end
    end
  end
end

include Frank::DSL