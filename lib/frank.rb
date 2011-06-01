File.expand_path(File.dirname(__FILE__))

module Frank
  autoload :DSL, 'frank/dsl'
  autoload :HTTP, 'frank/http'
end

include Frank::DSL