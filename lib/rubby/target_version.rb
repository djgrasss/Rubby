module Rubby
  class TargetVersion
    include Comparable

    attr_accessor :version

    def initialize(v=nil)
      @version = v
      @version = "#{RUBY_VERSION}p#{RUBY_PATCHLEVEL}" if v.nil? || v == ""
    end

    def r18?
      major == 18
    end

    def r19?
      major == 19
    end

    def r20?
      major == 20
    end

    def major
      version.split(".")[0..1].join('').to_i
    end

    def minor
      version.split(".")[2].to_i
    end

    def patch
      version.split("p")[1].to_i
    end

    def to_s
      version
    end

    def <=>(other)
      major <=> other
    end
  end
end
