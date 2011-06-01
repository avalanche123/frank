module Frank::HTTP
  class Request
    attr_writer :path

    def initialize(method)
      @method = method
      @headers = {}
    end

    def body=(body)
      if @method === "TRACE"
        raise RequestCannotHaveBodyError unless body.nil?
      end
      @body = body
    end

    def method_missing(method, *args)
      super unless match = /^(\w+)$/.match(method)
      raise ArgumentError if args.empty?
      args = args.map { |h| h.to_s }.join(",") if args.respond_to?(:map)
      @headers[match[1].to_sym] = args
    end

    def to_s
      s = "#{@method} #{@path} HTTP/1.1\r\n"
      @headers.each do |name, value|
        s << "#{name.to_s.split(/[\-\_]/).map { |s| s.capitalize }.join("-")}: #{value.to_s}\r\n"
      end
      s
    end

    def m(header, attributes = {})
      MediaRange.new(header, attributes)
    end
  end
end