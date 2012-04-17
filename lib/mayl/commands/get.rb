module Mayl
  module Commands
    # Public: The Get command accepts a key and returns a summary of the
    # values for that key in every locale.
    #
    # Example
    # 
    #   command = Get.new(env, 'activerecord.models.post')
    #   command.execute
    #   # Outputs:
    #   #   ca: Article
    #   #   es: Artículo
    #   #   en: Post
    #
    class Get
      attr_reader :key

      # Public: Initializes a new Get command.
      #
      # env - the global environment
      # key - the String key to get the value of
      def initialize(env, key)
        @env = env
        @key = key
      end

      # Public: Executes the command, iterating over each locale, asking the
      # value for the key, and printing it out.
      #
      # Returns nothing.
      def execute
        locales.each do |locale|
          print "  #{locale}: #{locale.get qualified_key}\n"
        end
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
        [@env.namespace.to_s, @key].join('.')
      end
    end
  end
end
