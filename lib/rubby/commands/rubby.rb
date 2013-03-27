require 'trollop'
require 'rubby'

@option_parser = Trollop::Parser.new do
  version "Rubby version #{Rubby::VERSION}"
  banner <<-EOS
Rubby: a little wee Ruby language.
http://rubby-lang.org/

Usage:
\trubby [options] <filename>

where [options] are:
EOS
  opt :transpile, "Transpile a Rubby file to Ruby.",           :default => false, :short => 't'
  opt :output,    "Save transpiler output to a specific file", :type => String, :default => nil, :depends => :transpile, :short => 'o'
  opt :help,      "This output",                               :default => false, :short => 'h'
  opt :target,    "Target Ruby version",                       :type => String, :default => Rubby::TargetVersion.new.to_s, :short => 'r'
end

def main
  opts = @option_parser.parse
  file = @option_parser.leftovers.first
  usage if opts[:help] || !file
  if opts[:transpile]
    if opts[:output] == '-'
      puts Rubby.transpile(File.read(file), file, opts[:target])
    else
      Rubby.transpile_file(file, opts[:output], opts[:target])
    end
  else
    Rubby.interpret_file(file, opts[:target])
  end
rescue Trollop::HelpNeeded
  usage
end

def usage
  @option_parser.educate
  exit 1
end

main
