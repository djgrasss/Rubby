require 'rubby/version'
require 'rubby/exceptions'
require 'rubby/lexer'
require 'rubby/nodes'
require 'rubby/parser'
require 'rubby/runner'
require 'rubby/target_version'
require 'rubby/transpiler'
require 'rubby/rubby_loader'

module Rubby
  module_function

  def transpile(source,version=nil)
    Transpiler.new(source, version).process
  end

  def interpret(source, version=nil)
    Kernel.eval(transpile(source,version), TOPLEVEL_BINDING)
  end

  def transpile_file(source, destination = source.gsub(/\.rbb$/, '.rb'), version=nil)
    File.open(source, 'r') do |src|
      begin
        File.open(destination, 'w') do |dest|
          dest.write(transpile(src.read) + "\n")
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
