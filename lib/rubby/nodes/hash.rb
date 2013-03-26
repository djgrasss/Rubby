module Rubby::Nodes
  class Hash < Base
    child :contents, [HashElement]

    def to_ruby(runner)
      return '{}' if contents.size == 0
      if (runner.target.r18?)
        hash_for_18(runner)
      else
        hash_for_19(runner)
      end
    end

    def needs_delimiting?
      true
    end

    private

    def hash_for_19(runner)
      return hash_for_18(runner) unless contents.all? { |e| e.key.is_a? Symbol }
      result = []
      result << "{" if needs_delimiting?
      elements = []
      contents.each do |element|
        e = []
        e << element.key.content.value + ":"
        e << "#{inline(element.value, runner)}"
        elements << e.join(' ')
      end
      result << elements.join(', ')
      result << "}" if needs_delimiting?
      [result.join(" ")]
    end

    def hash_for_18(runner)
      result = []
      result << "{" if needs_delimiting?
      elements = []
      contents.each do |element|
        e = []
        e << inline(element.key, runner)
        e << '=>'
        e << "#{inline(element.value, runner)}"
        elements << e.join(' ')
      end
      result << elements.join(', ')
      result << "}" if needs_delimiting?
      [result.join(" ")]
    end
  end
end
