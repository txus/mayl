module Mayl
  module Commands
    # Public: The Cd command enters in a YAML namespace.
    #
    # Example
    # 
    #   command = Edit.new(env, 'es', 'Artículo')
    #   command.execute
    #
    class Cd
      # Public: Initializes a new Cd command.
      #
      # env  - the global environment
      # path - the path to cd in
      def initialize(env, path)
        @env  = env
        @path = path
      end

      # Public: Adds the path to the namespace.
      #
      # Returns nil.
      def execute
        case @path
        when ".."
          ns = @env.namespace.split('.')
          ns.pop
          @env.namespace = ns.join('.')
        when "."
          @env.namespace = ""
        else
          @env.namespace << '.' << @path
        end
        nil
      end
    end
  end
end
