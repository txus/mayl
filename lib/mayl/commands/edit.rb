module Mayl
  module Commands
    # Public: The Edit command quickly edits the last value consulted with Get
    # or Set.
    #
    # Example
    # 
    #   command = Edit.new(env, 'es', 'Artículo')
    #   command.execute
    #
    class Edit
      attr_reader :locale, :value

      # Public: Initializes a new Get command.
      #
      # env    - the global environment
      # locale - the locale that we want to edit
      # value  - the value to set
      def initialize(env, locale, value)
        @env    = env
        @key    = @env.last_value
        raise ArgumentError, "You must get or set a key before calling edit" unless @key
        @locale = locale
        @value  = value
      end

      # Public: Executes the command, editing the @key for the given @locale.
      #
      # Returns the key.
      def execute
        key = qualified_key
        locale = locales.detect do |locale|
          locale.name.to_s == @locale.to_s
        end

        locale.set key, @value
        key
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
