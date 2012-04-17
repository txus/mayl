require 'yaml'

module Mayl
  # Public: This module is responsible for loading YAML files and converting
  # them to Locale objects.
  #
  # Example
  #
  #   Loader.load('config/locales')
  #   # => [#<Locale:...>, #<Locale:...>]
  #
  module Loader
    # Public: Maps a set of YAML files in a directory to Locale objects, to
    # work comfortably with them.
    #
    # path - The path under which to scan for YAML files.
    #
    # Returns an Array of Locale objects.
    def self.load(path)
      Dir[File.expand_path(path) << "/*.yml"].map { |filename|
        Locale.new filename, YAML.load(File.read(filename))
      }
    end
  end
end
