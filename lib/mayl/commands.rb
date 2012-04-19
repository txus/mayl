module Mayl
  # Public: The Commands module is a namespace for all the commands that Mayl
  # uses.
  module Commands
    def self.autocomplete(line, env)
      key = line.split.first || ''

      # Try to get namespaces or keys
      keys = env.autocomplete(key)
      return keys if keys.any?

      # If not, autocomplete commands
      opts = constants.map(&:to_s).map(&:downcase)
      opts.grep(/^#{Regexp.escape(key)}/)
    end
  end
end

require 'mayl/commands/set'
require 'mayl/commands/get'
require 'mayl/commands/edit'
require 'mayl/commands/cd'
require 'mayl/commands/exit'
require 'mayl/commands/ls'
