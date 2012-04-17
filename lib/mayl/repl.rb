module Mayl
  # Public: The class responsible for reading user input, interpreting it and
  # executing associated commands.
  class Repl
    attr_reader :parser

    # Public: Initializes a new REPL from a given path.
    #
    # path - The path to get the locales from (defaults to 'config/locales').
    def initialize(path)
      path    ||= 'config/locales'
      @env    = Env.new(path)
      @parser = Parser.new(@env)
    end

    # Public: Fires up the REPL that parses and executes given commands.
    #
    # Returns nothing.
    def start
      locales = @env.locales.map(&:name)
      prompt = "> "
      puts "Detected locales: #{locales.join(', ')}"
      while (print prompt; input = $stdin.gets)
        begin
          value = @parser.parse(input.chomp).execute
          @env.last_value = value
          @env.commit
          prompt = [@env.namespace, '> '].reject(&:empty?).join ' '
        rescue => e
          print "Error: #{e.message}"
        ensure
          print "\n"
        end
      end
    end
  end
end