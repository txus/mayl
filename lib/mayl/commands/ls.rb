module Mayl
  module Commands
    # Public: The Cd command navigates through YAML namespaces.
    #
    # Example
    # 
    #   command = Ls.new(env)
    #   command.execute
    #
    class Ls
      # Public: Initializes a new Cd command.
      #
      # env  - the global environment
      def initialize(env)
        @env = env
      end

      # Public: Adds the path to the namespace.
      #
      # Returns nil.
      def execute
        locales.map { |locale|
          locale.peek(@env.namespace)
        }.flatten.uniq.each do |option|
          print "#{option} "
        end
        nil
      end

      #######
      private
      #######

      # Public: Returns an Array with the locales of the environment.
      def locales
        @env.locales
      end
    end
  end
end
