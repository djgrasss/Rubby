require 'rubby'
require 'trollop'
require 'readline'

@opts = Trollop.options do
  version "Rubby version #{Rubby::VERSION}"
  banner <<-EOS
Rubby: a little wee Ruby language.
http://rubby-lang.org/

Usage:
\tirbb [options]

where [options] are:
EOS
  opt :help,   'This output',         :default => false, :short => 'h'
  opt :target, 'Target Ruby version', :type => String, :default => Rubby::TargetVersion.new.to_s, :short => 'r'
end

def repl
  loop do
    line = collect_lines
    begin
      result = Rubby.interpret(line, @opts[:target])
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

puts "Rubby version #{Rubby::VERSION}, starting REPL on Ruby #{Rubby::TargetVersion.new}"
puts "  use '\\' on the end of line for multiline input."
repl

