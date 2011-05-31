module Frank::HTTP
  class Request
    attr_reader :body

    def initialize(method)
      @method = method
    end

    def body=(body)
      if @method === "TRACE"
        raise RequestCannotHaveBodyError unless body.nil?
      end
      @body = body
    end
  end
end