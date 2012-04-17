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
      # Returns the key.
      def execute
        locales.each do |locale|
          result = locale.get qualified_key
          if result.is_a? String
            print "  #{locale.to_s}: #{result}\n"
          else
            print "  #{locale.to_s}: (empty)\n"
          end
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
