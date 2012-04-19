module Mayl
  # Public: Represents the global state with the loaded locales, and has the
  # ability to save locales to disk.
  class Env
    attr_reader :locales
    attr_accessor :last_value
    attr_accessor :namespace

    # Public: Autocompletes a key looking at the current namespace and
    # their contents.
    #
    # key - the partial key to consult in the namespace.
    #
    # Returns an Array of results.
    def autocomplete(key)
      peek.grep(/^#{Regexp.escape(key)}/)
    end

    # Public: Returns the keys inside a namespace, by default ours.
    #
    # namespace - the namespace to peek in. It's ours by default.
    #
    # Returns an Array of results.
    def peek(namespace=self.namespace)
      locales.map { |locale| locale.peek(namespace) }.flatten.uniq
    end

    # Public: Initializes a new Env loading the locales from a path.
    def initialize(path)
      @locales    = Loader.load(path)
      @last_value = nil
      @namespace  = ""
    end

    # Public: Saves any changes to disk.
    def commit
      @locales.each(&:commit)
    end
  end
end
