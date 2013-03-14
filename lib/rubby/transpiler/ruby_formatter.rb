module Rubby
  class Transpiler
    class RubyFormatter
      attr_accessor :ruby_ary
      attr_writer   :indent

      def self.process(ruby_ary)
        self.new(ruby_ary).process
      end

      def initialize(ruby_ary)
        @ruby_ary = ruby_ary
      end

      def indent
        @indent ||= '  '
      end

      def process
        depth = 0
        result = ""
        process_ary = proc do |chunk|
          if chunk.is_a? Array
            depth = depth + 1
            chunk.each(&process_ary)
          elsif chunk.is_a? String
            result << prepend_with_indent(depth, chunk)
          end
        end
        ruby_ary.each do |statement|
          statement.each(&process_ary)
        end
        result
      end

      private

      def prepend_with_indent(depth,str)
        "#{indent * depth}#{str}\n"
      end

    end
  end
end
