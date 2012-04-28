module Mayl
  module Colors
    def color(name, str)
      code = case name
             when :black   then "\033[30m"
             when :red     then "\033[31m"
             when :green   then "\033[32m"
             when :brown   then "\033[33m"
             when :blue    then "\033[34m"
             when :magenta then "\033[35m"
             when :cyan    then "\033[36m"
             when :gray    then "\033[37m"
             end
      endcode = "\033[0m"

      [code,str,endcode].join
    end
  end
end
