module Mayl
  module Commands
    # Public: The Set command accepts a key and asks the user to type in the
    # translations for that key in each of the locales.
    #
    # Example
    # 
    #   command = Set.new(env, 'activerecord.models.post')
    #   command.execute
    #     ca: <type something>
    #     en: <type something>
    #   # Now locales have those values set.
    #
    class Set
      attr_reader :key

      # Public: Initializes a new Set command.
      #
      # env - the global environment
      # key - the String key to be set
      def initialize(env, key)
        @env = env
        @key = key
      end

      # Public: Executes the command, iterating over each locale, asking the
      # user for a value, and setting it.
      #
      # Returns the key.
      def execute
        locales.each do |locale|
          print "  #{locale.to_s}: "
          locale.set qualified_key, gets.chomp
        end
        @key
      end

      #######
      private
      #######

      # Public: Returns an Array with the locales of the environment.
      def locales
        @env.locales
      end

      # Public: Returns the given String key according to the qualified
      # namespace we are in.
      def qualified_key
        [@env.namespace.to_s, @key].reject(&:empty?).compact.join('.')
      end
    end
  end
end
