module Mayl
  # Public: Represents the global state with the loaded locales, and has the
  # ability to save locales to disk.
  class Env
    attr_reader :locales

    # Public: Initializes a new Env loading the locales from a path.
    def initialize(path)
      @locales = Loader.load(path)
    end

    # Public: Saves any changes to disk.
    def commit
      @locales.each(&:commit)
    end
  end
end
