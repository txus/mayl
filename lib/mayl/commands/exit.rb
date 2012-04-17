module Mayl
  module Commands
    # Public: The Exit command exits the program.
    #
    # Example
    # 
    #   command = Exit.new(env)
    #   command.execute
    #
    class Exit
      # Public: Initializes a new Exit command.
      #
      # env  - the global environment
      def initialize(env)
      end

      # Public: Exits the program.
      #
      # Returns nothing.
      def execute
        exit(0)
      end
    end
  end
end
