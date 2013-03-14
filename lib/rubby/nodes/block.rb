module Rubby::Nodes
  class Block < Base
    child :args, [Base]
    child :contents, [Base]

    def to_ruby(runner)
      if parent_is_a_call?
        process_to_block(runner)
      elsif runner.target >= 19
        process_to_stabby_lambda(runner)
      else
        process_to_lambda(runner)
      end
    end

    private

    def parent_is_a_call?
      parent && parent.is_a?(Rubby::Nodes::Call)
    end

    def process_to_block(runner,inside_args=true)
      case contents.size
      when 0
        ["{#{process_arguments(runner,inside_args)}}"]
      when 1
        ["{#{process_arguments(runner,inside_args)}#{contents[0].to_ruby(runner)} }"]
      else
        ["do #{process_arguments(runner,inside_args)}", contents.map { |n| n.to_ruby(runner) }, 'end']
      end
    end

    def process_to_lambda(runner)
      ruby = process_to_block(runner)
      ruby[0] = "lambda #{ruby[0]}"
      ruby
    end

    def process_to_stabby_lambda(runner)
      ruby = process_to_block(runner, false)
      ruby[0] = "-> #{process_arguments(runner,'')}#{ruby[0]}"
      ruby
    end

    def process_arguments(runner,run=true,delim='|')
      if run && args.size > 0
        " #{delim} #{args.map { |n| n.to_ruby(runner) }.join(', ')} #{delim} "
      else
        ''
      end
    end
  end
end
