module Rubby
  module Exceptions
    Base             = Class.new(Exception)
    OverrideMePlease = Class.new(Base)
    Indent           = Class.new(Base)
    Inline           = Class.new(Base)
    SyntaxError      = Class.new(Base)
  end
end
