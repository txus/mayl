module Mayl
  module Commands
    # Public: The Cd command navigates through YAML namespaces.
    #
    # Example
    # 
    #   command = Cd.new(env, 'models.bla')
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
          if @env.namespace.empty?
            @env.namespace = @path
          else
            @env.namespace += '.' << @path
          end
        end
        nil
      end
    end
  end
end
