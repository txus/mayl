require 'yaml'

module Mayl
  # Public: A Locale is the representation of a YAML translation file.
  #
  # Example
  #
  #   locale = Locale.new(:ca, {'ca' => {'activerecord' => ... }})
  #   locale.set('activerecord.models.comment', 'Comentari')
  #   locale.get('activerecord.models.comment')
  #   # => 'Comentari
  #
  class Locale
    attr_reader :name

    # Public: Initializes a new Locale.
    #
    # path - the filename path of the YAML file
    # hash - the Hash outputted by the YAML parser
    def initialize(path, hash)
      @path  = path
      @name  = path.split('/').last.gsub('.yml','').to_sym
      @data  = hash[name.to_s]
      @dirty = false
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
        acc[name] ||= {}
      end

      @dirty = true

      path[name] = value
    end

    # Public: Gets the value for a given key.
    #
    # key - the String key to be set, fully qualified
    #
    # Returns the String value.
    def get(key)
      key.split('.').inject(@data) do |acc, name|
        acc[name] ||= {}
      end
    end

    # Public: Saves any changes to disk.
    #
    # Returns nothing.
    def commit
      return false unless @dirty

      File.open(@path, 'w') do |f|
        f.write YAML.dump({ @name.to_s => @data })
      end
    end
  end
end
