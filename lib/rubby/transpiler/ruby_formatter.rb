module Rubby
  class Transpiler
    class RubyFormatter
      attr_accessor :ruby_ary
      attr :indent_count, true

      def self.process(ruby_ary)
        self.new(ruby_ary).process
      end

      def initialize(ruby_ary)
        @ruby_ary = ruby_ary
        @indent_count   = -1
      end

      def indent
        '  '
      end


      def process(nodes=ruby_ary)

        if nodes.is_a? Array
          if nodes.all? {|node| node.is_a? Array}
            puts "node count: #{nodes.size}"
            process(nodes.flatten(1))

          else
            self.indent_count += 1
            result = nodes.map {|n| process(n) }.join("\n")
            self.indent_count -= 1
            return result
          end

        else
          "#{indent*indent_count}#{nodes}"
        end
      end


    end
  end
end
