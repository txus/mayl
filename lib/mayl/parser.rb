module Mayl
  # Public: The parser interprets commands and executes them.
  class Parser
    # Public: initializes a new Parser with an environment.
    #
    # env - the global state.
    def initialize(env)
      @env = env
    end

    # Public: Parses a given input and creates a command representation for it.
    #
    # Returns a Command.
    def parse(input)
      operator, *operands = input.split
      klass = Commands.const_get(operator.capitalize)
      klass.new(@env, *Array(operands))
    end
  end
end
