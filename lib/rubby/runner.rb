module Rubby
  class Runner
    attr_accessor :source

    def initialize(source)
      self.source = source
    end

    def process; end
  end
end
