require "readline"

module Mayl
  # Public: The class responsible for reading user input, interpreting it and
  # executing associated commands.
  class Repl
    include Colors
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
      stty_save = `stty -g`.chomp
      prompt = color(:red, "> ")
      puts color(:green, "Detected locales: #{locales.join(', ')}")

      env = @env
      Readline.completion_proc = proc { |s| Commands.autocomplete(s, env) }
      Readline.completion_append_character = ''

      begin
        while input = Readline.readline(prompt, true)
          begin
            value = @parser.parse(input.chomp).execute
            @env.last_value = value
            @env.commit
            prompt = color(:red, [@env.namespace, '> '].reject(&:empty?).join(' '))
          rescue => e
            print "Error: #{e.message}"
          ensure
            print "\n"
          end
        end
      rescue Interrupt
        system("stty", stty_save)
        exit
      end
    end
  end
end