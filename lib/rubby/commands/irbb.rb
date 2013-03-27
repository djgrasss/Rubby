require 'rubby'
require 'readline'

def repl
  loop do
    line = collect_lines
    begin
      result = Rubby.interpret(line)
    rescue SystemExit
      exit
    rescue Exception => e
      puts "#{e.class}: #{e.message}"
      puts e.backtrace.join("\n")
    end
    puts " => %s" % result.inspect
  end
end

def collect_lines(multiline=false)
  line = Readline.readline(prompt(multiline), true)
  unless line
    puts "Exiting Rubby REPL"
    exit 0
  end
  line = line.chomp
  if line[-1] == "\\"
    line = line[0..-2] + "\n"
    line += collect_lines(true)
  end
  line + "\n"
end

def prompt(multiline=false)
  multiline ? '>| ' :  '>> '
end

puts "Rubby version #{Rubby::VERSION}, starting REPL"
puts "  use '\\' on the end of line for multiline input."
repl

