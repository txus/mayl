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
        path = path.split('.').reject(&:empty?).compact.join('.') if path =~ /\w/
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
          check_namespace!

          if @env.namespace.empty?
            @env.namespace = @path
          else
            @env.namespace += '.' << @path
          end
        end
        nil
      end

      # Public: Checks that you're not trying to enter a leaf.
      #
      # Raises an ArgumentError if you are.
      def check_namespace!
        namespace = [@env.namespace, @path].reject(&:empty?).join('.')
        matches   = @env.peek(namespace).compact

        if matches.empty?
          key = @path.split('.').last
          raise ArgumentError, "Can't cd to #{key} -- it's a leaf"
        end
      end
    end
  end
end
