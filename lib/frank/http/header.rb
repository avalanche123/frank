module Frank::HTTP
  class Header
    def initialize(value, attributes={})
      @value, @attributes = value, attributes
    end

    def to_s
      s = @value.to_s
      @attributes.each { |key, value| s += ";#{key}=#{value}" } unless @attributes.empty?
      s
    end
  end
end