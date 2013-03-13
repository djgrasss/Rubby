module Rubby
  class Transpiler < Runner
    def process
      tree.map(&:to_ruby).join("\n")
    end
  end
end
