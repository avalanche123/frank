module Frank::DSL
  [:get, :post, :put, :delete, :patch,
   :head, :options, :trace, :connect].each do |method|
    define_method method do |path, &block|
      Frank::HTTP::RequestFactory.create_request(method.to_s.upcase, path, &block)
    end
  end
end