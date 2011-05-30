module Frank::HTTP
  class RequestFactory
    @allowed_methods ||= ["GET", "POST", "PUT", "DELETE", "HEAD", "PATCH", "OPTIONS", "TRACE"]

    module ClassMethods
      def create_request(method, &block)
        raise ArgumentError unless block_given? and @allowed_methods.include?(method)
        request = Request.new(method)
        request.body = request.instance_eval(&block)
        request
      end
    end
    extend ClassMethods
  end
end