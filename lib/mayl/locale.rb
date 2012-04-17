require 'ostruct'

module Mayl
  # Public: A Locale is the representation of a YAML translation file, but
  # traversable as an OpenStruct, and with some convenience methods to set and
  # get keys.
  #
  # Example
  #
  #   locale = Locale.new(:ca, {'ca' => {'activerecord' => ... }})
  #   locale.activerecord.models.post
  #   # => 'Article'
  #   locale.set('activerecord.models.comment', 'Comentari')
  #   locale.get('activerecord.models.comment')
  #   # => 'Comentari
  #
  class Locale
    attr_reader :name

    # Anonymous function used to generate a deep-openstruct from a deep Hash
    # object. Meant to use with #inject on a Hash.
    Iterator = lambda do |acc, elem|
      attr    = Array(elem).first
      element = elem.last
      # Deep-generate an OpenStruct if it's not the leaf of the tree
      element = element.inject(OpenStruct.new, &Iterator) unless element.is_a?(String)

      acc.send(:"#{attr}=", element)
      acc
    end

    # Public: Initializes a new Locale.
    #
    # name - the Symbol ISO for the locale (:ca, :es)
    # hash - the Hash outputted by the YAML parser
    def initialize(name, hash)
      @name = name
      @data = hash[name.to_s].inject(OpenStruct.new, &Iterator)
    end

    # Public: Sets a key to a given value.
    #
    # key   - the String key to be set, fully qualified
    # value - the new value to give to that key
    #
    # Returns nothing.
    def set(key, value)
      ary       = key.split('.')
      qualifier = ary[0..-2]
      name      = ary.last

      path = qualifier.inject(@data) do |acc, name|
        acc.send(:"#{name}=", OpenStruct.new) unless acc.respond_to?(name)
        acc.send(name)
      end
      
      path.send("#{name}=", value)
    end

    # Public: Gets the value for a given key.
    #
    # key   - the String key to be set, fully qualified
    #
    # Returns the String value.
    def get(key)
      key.split('.').inject(@data) do |acc, name|
        acc.send(name)
      end
    end

    # Public: Convenience DSL to traverse the OpenStruct more comfortably.
    #
    # m - the property to get
    #
    # Returns the String value of that property.
    def method_missing(m, *args, &block)
      @data.send(m) || super
    end
  end
end
