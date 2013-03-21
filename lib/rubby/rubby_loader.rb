require 'polyglot'

module Rubby
  class RubbyLoader
    def self.load(filename,options=nil,&block)
      rubby = File.read(filename)
      ruby  = Rubby.transpile(rubby)
      Kernel.eval(ruby, TOPLEVEL_BINDING)
    end

    def self.register
      Polyglot.register('rbb', self)
    end
  end

  RubbyLoader.register
end
