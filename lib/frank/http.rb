module Frank::HTTP
  autoload :Request, 'frank/http/request'
  autoload :RequestFactory, 'frank/http/request_factory'
  autoload :MediaRange, 'frank/http/media_range'
end

require 'frank/http/errors'