require 'rubby/version'
require 'rubby/exceptions'
require 'rubby/lexer'
require 'rubby/nodes'
require 'rubby/parser'
require 'rubby/target_version'
require 'rubby/transpiler'
require 'rubby/rubby_loader'

Dir[File.expand_path('../../lib/rubby/tasks/**/*.rake', __FILE__)].each { |f| load f } if defined? Rake

module Rubby

  module_function

  def transpile(source,filename='STDIN', version=nil)
    Transpiler.new(source, filename, version).process
  end

  def interpret(source, version=nil)
    Kernel.eval(transpile(source,'STDIN', version), TOPLEVEL_BINDING)
  end

  def interpret_file(source, version=nil)
    Kernel.eval(transpile(File.read(source), source, version), TOPLEVEL_BINDING)
  end

  def transpile_file(source, destination=nil, version=nil)
    destination = source.gsub(/\.rbb$/, '.rb') unless destination
    File.open(source, "r") do |src|
      begin
        ruby = transpile(src.read, src.path)
        File.open(destination, "w") do |dest|
          dest.write("#{ruby}\n")
        end
      rescue Errno::ENOENT => e
        $stderr.puts "Unable to open destination file: #{e.message}"
        exit 1
      end

    end
  rescue Errno::ENOENT => e
    $stderr.puts "Unable to open source file: #{e.message}"
    exit 1
  end
end
