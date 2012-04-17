require 'ostruct'

module Mayl
  class Locale
    attr_reader :name

    Iterator = lambda do |acc, elem|
      attr = Array(elem).first

      if elem.last.is_a? String
        element = elem.last
      else
        element = elem.last.inject(OpenStruct.new, &Iterator)
      end

      acc.send(:"#{attr}=", element)
      acc
    end

    def initialize(name, hash)
      @name = name
      @data = hash[name.to_s].inject(OpenStruct.new, &Iterator)
    end

    def method_missing(m, *args, &block)
      @data.send(m) || super
    end
  end
end
