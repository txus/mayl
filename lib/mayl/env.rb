module Mayl
  # Public: Represents the global state with the loaded locales.
  class Env
    attr_reader :locales

    # Public: Initializes a new Env loading the locales from a path.
    def initialize(path)
      @locales = Loader.load(path)
    end
  end
end
