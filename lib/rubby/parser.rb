require 'kpeg/compiled_parser'

class Rubby::Parser < KPeg::CompiledParser


  def ast
    @ast || @result
  end


  # :stopdoc:

  module Rubby::Nodes
    class Node; end
    class Array < Node
      def initialize(values)
        @values = values
      end
      attr_reader :values
    end
    class Call < Node
      def initialize(name, arguments)
        @name = name
        @arguments = arguments
      end
      attr_reader :name
      attr_reader :arguments
    end
    class CallArgument < Node
      def initialize(expression)
        @expression = expression
      end
      attr_reader :expression
    end
    class CallArgumentSplat < Node
      def initialize(expression)
        @expression = expression
      end
      attr_reader :expression
    end
    class CallWithBlock < Node
      def initialize(call, statements)
        @call = call
        @statements = statements
      end
      attr_reader :call
      attr_reader :statements
    end
    class Comment < Node
      def initialize(value)
        @value = value
      end
      attr_reader :value
    end
    class Constant < Node
      def initialize(value)
        @value = value
      end
      attr_reader :value
    end
    class ExpressionGroup < Node
      def initialize(expression)
        @expression = expression
      end
      attr_reader :expression
    end
    class Float < Node
      def initialize(value)
        @value = value
      end
      attr_reader :value
    end
    class Hash < Node
      def initialize(values)
        @values = values
      end
      attr_reader :values
    end
    class HashElement < Node
      def initialize(key, value)
        @key = key
        @value = value
      end
      attr_reader :key
      attr_reader :value
    end
    class Integer < Node
      def initialize(value)
        @value = value
      end
      attr_reader :value
    end
    class Interpolation < Node
      def initialize(expression)
        @expression = expression
      end
      attr_reader :expression
    end
    class Regex < Node
      def initialize(values, mods)
        @values = values
        @mods = mods
      end
      attr_reader :values
      attr_reader :mods
    end
    class RegexSeq < Node
      def initialize(value)
        @value = value
      end
      attr_reader :value
    end
    class SimpleString < Node
      def initialize(value)
        @value = value
      end
      attr_reader :value
    end
    class String < Node
      def initialize(values)
        @values = values
      end
      attr_reader :values
    end
    class Symbol < Node
      def initialize(value)
        @value = value
      end
      attr_reader :value
    end
  end
  def array(values)
    Rubby::Nodes::Array.new(values)
  end
  def call(name, arguments)
    Rubby::Nodes::Call.new(name, arguments)
  end
  def call_argument(expression)
    Rubby::Nodes::CallArgument.new(expression)
  end
  def call_argument_splat(expression)
    Rubby::Nodes::CallArgumentSplat.new(expression)
  end
  def call_with_block(call, statements)
    Rubby::Nodes::CallWithBlock.new(call, statements)
  end
  def comment(value)
    Rubby::Nodes::Comment.new(value)
  end
  def constant(value)
    Rubby::Nodes::Constant.new(value)
  end
  def expression_group(expression)
    Rubby::Nodes::ExpressionGroup.new(expression)
  end
  def float(value)
    Rubby::Nodes::Float.new(value)
  end
  def hash(values)
    Rubby::Nodes::Hash.new(values)
  end
  def hash_element(key, value)
    Rubby::Nodes::HashElement.new(key, value)
  end
  def integer(value)
    Rubby::Nodes::Integer.new(value)
  end
  def interpolation(expression)
    Rubby::Nodes::Interpolation.new(expression)
  end
  def regex(values, mods)
    Rubby::Nodes::Regex.new(values, mods)
  end
  def regex_seq(value)
    Rubby::Nodes::RegexSeq.new(value)
  end
  def simple_string(value)
    Rubby::Nodes::SimpleString.new(value)
  end
  def string(values)
    Rubby::Nodes::String.new(values)
  end
  def symbol(value)
    Rubby::Nodes::Symbol.new(value)
  end

  # eof = !.
  def _eof
    _save = self.pos
    _tmp = get_byte
    _tmp = _tmp ? nil : true
    self.pos = _save
    set_failed_rule :_eof unless _tmp
    return _tmp
  end

  # space = (" " | "\t")
  def _space

    _save = self.pos
    while true # choice
      _tmp = match_string(" ")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\t")
      break if _tmp
      self.pos = _save
      break
    end # end choice

    set_failed_rule :_space unless _tmp
    return _tmp
  end

  # nl = ("\n" | "" | "\n" | "\n")
  def _nl

    _save = self.pos
    while true # choice
      _tmp = match_string("\n")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\r")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\r\n")
      break if _tmp
      self.pos = _save
      _tmp = match_string("\n\r")
      break if _tmp
      self.pos = _save
      break
    end # end choice

    set_failed_rule :_nl unless _tmp
    return _tmp
  end

  # keywords = ("module" | "class" | "if" | "else" | "elsif" | "unless")
  def _keywords

    _save = self.pos
    while true # choice
      _tmp = match_string("module")
      break if _tmp
      self.pos = _save
      _tmp = match_string("class")
      break if _tmp
      self.pos = _save
      _tmp = match_string("if")
      break if _tmp
      self.pos = _save
      _tmp = match_string("else")
      break if _tmp
      self.pos = _save
      _tmp = match_string("elsif")
      break if _tmp
      self.pos = _save
      _tmp = match_string("unless")
      break if _tmp
      self.pos = _save
      break
    end # end choice

    set_failed_rule :_keywords unless _tmp
    return _tmp
  end

  # rejected = ("do" | "and" | "or" | "not" | "return" | "proc" | "lambda")
  def _rejected

    _save = self.pos
    while true # choice
      _tmp = match_string("do")
      break if _tmp
      self.pos = _save
      _tmp = match_string("and")
      break if _tmp
      self.pos = _save
      _tmp = match_string("or")
      break if _tmp
      self.pos = _save
      _tmp = match_string("not")
      break if _tmp
      self.pos = _save
      _tmp = match_string("return")
      break if _tmp
      self.pos = _save
      _tmp = match_string("proc")
      break if _tmp
      self.pos = _save
      _tmp = match_string("lambda")
      break if _tmp
      self.pos = _save
      break
    end # end choice

    set_failed_rule :_rejected unless _tmp
    return _tmp
  end

  # module = "module"
  def _module
    _tmp = match_string("module")
    set_failed_rule :_module unless _tmp
    return _tmp
  end

  # class = "class"
  def _class
    _tmp = match_string("class")
    set_failed_rule :_class unless _tmp
    return _tmp
  end

  # if = "if"
  def _if
    _tmp = match_string("if")
    set_failed_rule :_if unless _tmp
    return _tmp
  end

  # else = "else"
  def _else
    _tmp = match_string("else")
    set_failed_rule :_else unless _tmp
    return _tmp
  end

  # elsif = "elsif"
  def _elsif
    _tmp = match_string("elsif")
    set_failed_rule :_elsif unless _tmp
    return _tmp
  end

  # unless = "unless"
  def _unless
    _tmp = match_string("unless")
    set_failed_rule :_unless unless _tmp
    return _tmp
  end

  # raise = ("raise" | "o_O")
  def _raise

    _save = self.pos
    while true # choice
      _tmp = match_string("raise")
      break if _tmp
      self.pos = _save
      _tmp = match_string("o_O")
      break if _tmp
      self.pos = _save
      break
    end # end choice

    set_failed_rule :_raise unless _tmp
    return _tmp
  end

  # rescue = "rescue"
  def _rescue
    _tmp = match_string("rescue")
    set_failed_rule :_rescue unless _tmp
    return _tmp
  end

  # ensure = "ensure"
  def _ensure
    _tmp = match_string("ensure")
    set_failed_rule :_ensure unless _tmp
    return _tmp
  end

  # proc = "&>"
  def _proc
    _tmp = match_string("&>")
    set_failed_rule :_proc unless _tmp
    return _tmp
  end

  # identifier = /[a-z_][a-zA-Z0-9_]*/
  def _identifier
    _tmp = scan(/\A(?-mix:[a-z_][a-zA-Z0-9_]*)/)
    set_failed_rule :_identifier unless _tmp
    return _tmp
  end

  # constant_name = /([A-Z][a-zA-Z0-9_]+)/
  def _constant_name
    _tmp = scan(/\A(?-mix:([A-Z][a-zA-Z0-9_]+))/)
    set_failed_rule :_constant_name unless _tmp
    return _tmp
  end

  # constant_sep = "::"
  def _constant_sep
    _tmp = match_string("::")
    set_failed_rule :_constant_sep unless _tmp
    return _tmp
  end

  # constant_with_sep = constant_sep constant_name
  def _constant_with_sep

    _save = self.pos
    while true # sequence
      _tmp = apply(:_constant_sep)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_constant_name)
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_constant_with_sep unless _tmp
    return _tmp
  end

  # constant = < (constant_name constant_with_sep+ | constant_with_sep+ | constant_name) > {constant(text)}
  def _constant

    _save = self.pos
    while true # sequence
      _text_start = self.pos

      _save1 = self.pos
      while true # choice

        _save2 = self.pos
        while true # sequence
          _tmp = apply(:_constant_name)
          unless _tmp
            self.pos = _save2
            break
          end
          _save3 = self.pos
          _tmp = apply(:_constant_with_sep)
          if _tmp
            while true
              _tmp = apply(:_constant_with_sep)
              break unless _tmp
            end
            _tmp = true
          else
            self.pos = _save3
          end
          unless _tmp
            self.pos = _save2
          end
          break
        end # end sequence

        break if _tmp
        self.pos = _save1
        _save4 = self.pos
        _tmp = apply(:_constant_with_sep)
        if _tmp
          while true
            _tmp = apply(:_constant_with_sep)
            break unless _tmp
          end
          _tmp = true
        else
          self.pos = _save4
        end
        break if _tmp
        self.pos = _save1
        _tmp = apply(:_constant_name)
        break if _tmp
        self.pos = _save1
        break
      end # end choice

      if _tmp
        text = get_text(_text_start)
      end
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin; constant(text); end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_constant unless _tmp
    return _tmp
  end

  # integer_octal = /(0[1-9][0-9]*)/
  def _integer_octal
    _tmp = scan(/\A(?-mix:(0[1-9][0-9]*))/)
    set_failed_rule :_integer_octal unless _tmp
    return _tmp
  end

  # integer_decimal = /([1-9][0-9]*)/
  def _integer_decimal
    _tmp = scan(/\A(?-mix:([1-9][0-9]*))/)
    set_failed_rule :_integer_decimal unless _tmp
    return _tmp
  end

  # integer_zero = "0"
  def _integer_zero
    _tmp = match_string("0")
    set_failed_rule :_integer_zero unless _tmp
    return _tmp
  end

  # integer_hex = /(0x[0-9a-fA-F]+)/
  def _integer_hex
    _tmp = scan(/\A(?-mix:(0x[0-9a-fA-F]+))/)
    set_failed_rule :_integer_hex unless _tmp
    return _tmp
  end

  # integer_binary = /(0b[01]+)/
  def _integer_binary
    _tmp = scan(/\A(?-mix:(0b[01]+))/)
    set_failed_rule :_integer_binary unless _tmp
    return _tmp
  end

  # integer = < (integer_octal | integer_decimal | integer_hex | integer_binary | integer_zero) > {integer(text)}
  def _integer

    _save = self.pos
    while true # sequence
      _text_start = self.pos

      _save1 = self.pos
      while true # choice
        _tmp = apply(:_integer_octal)
        break if _tmp
        self.pos = _save1
        _tmp = apply(:_integer_decimal)
        break if _tmp
        self.pos = _save1
        _tmp = apply(:_integer_hex)
        break if _tmp
        self.pos = _save1
        _tmp = apply(:_integer_binary)
        break if _tmp
        self.pos = _save1
        _tmp = apply(:_integer_zero)
        break if _tmp
        self.pos = _save1
        break
      end # end choice

      if _tmp
        text = get_text(_text_start)
      end
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin; integer(text); end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_integer unless _tmp
    return _tmp
  end

  # float = < /([0-9]+\.[0-9]+)/ > {float(text)}
  def _float

    _save = self.pos
    while true # sequence
      _text_start = self.pos
      _tmp = scan(/\A(?-mix:([0-9]+\.[0-9]+))/)
      if _tmp
        text = get_text(_text_start)
      end
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin; float(text); end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_float unless _tmp
    return _tmp
  end

  # single_tick_string = "'" simple_string_seq:value "'" {string([value])}
  def _single_tick_string

    _save = self.pos
    while true # sequence
      _tmp = match_string("'")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_simple_string_seq)
      value = @result
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string("'")
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin; string([value]); end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_single_tick_string unless _tmp
    return _tmp
  end

  # simple_string_seq = < /(\\'|[^'])/* > {simple_string(text)}
  def _simple_string_seq

    _save = self.pos
    while true # sequence
      _text_start = self.pos
      while true
        _tmp = scan(/\A(?-mix:(\\'|[^']))/)
        break unless _tmp
      end
      _tmp = true
      if _tmp
        text = get_text(_text_start)
      end
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin; simple_string(text); end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_simple_string_seq unless _tmp
    return _tmp
  end

  # string_seq = < /[^\\"]+/ > {simple_string(text)}
  def _string_seq

    _save = self.pos
    while true # sequence
      _text_start = self.pos
      _tmp = scan(/\A(?-mix:[^\\"]+)/)
      if _tmp
        text = get_text(_text_start)
      end
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin; simple_string(text); end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_string_seq unless _tmp
    return _tmp
  end

  # double_tick_string = "\"" (interpolated_expression:s | string_seq:s)*:values "\"" {string(values)}
  def _double_tick_string

    _save = self.pos
    while true # sequence
      _tmp = match_string("\"")
      unless _tmp
        self.pos = _save
        break
      end
      _ary = []
      while true

        _save2 = self.pos
        while true # choice
          _tmp = apply(:_interpolated_expression)
          s = @result
          break if _tmp
          self.pos = _save2
          _tmp = apply(:_string_seq)
          s = @result
          break if _tmp
          self.pos = _save2
          break
        end # end choice

        _ary << @result if _tmp
        break unless _tmp
      end
      _tmp = true
      @result = _ary
      values = @result
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string("\"")
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin; string(values); end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_double_tick_string unless _tmp
    return _tmp
  end

  # string = (single_tick_string | double_tick_string)
  def _string

    _save = self.pos
    while true # choice
      _tmp = apply(:_single_tick_string)
      break if _tmp
      self.pos = _save
      _tmp = apply(:_double_tick_string)
      break if _tmp
      self.pos = _save
      break
    end # end choice

    set_failed_rule :_string unless _tmp
    return _tmp
  end

  # regex_seq = < /[^\\\/]+/ > {regex_seq(text)}
  def _regex_seq

    _save = self.pos
    while true # sequence
      _text_start = self.pos
      _tmp = scan(/\A(?-mix:[^\\\/]+)/)
      if _tmp
        text = get_text(_text_start)
      end
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin; regex_seq(text); end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_regex_seq unless _tmp
    return _tmp
  end

  # regex_mods = ("i" | "m" | "x" | "o")
  def _regex_mods

    _save = self.pos
    while true # choice
      _tmp = match_string("i")
      break if _tmp
      self.pos = _save
      _tmp = match_string("m")
      break if _tmp
      self.pos = _save
      _tmp = match_string("x")
      break if _tmp
      self.pos = _save
      _tmp = match_string("o")
      break if _tmp
      self.pos = _save
      break
    end # end choice

    set_failed_rule :_regex_mods unless _tmp
    return _tmp
  end

  # regex = "/" (interpolated_expression:s | regex_seq:s)*:values "/" regex_mods*:mods {regex(values,mods)}
  def _regex

    _save = self.pos
    while true # sequence
      _tmp = match_string("/")
      unless _tmp
        self.pos = _save
        break
      end
      _ary = []
      while true

        _save2 = self.pos
        while true # choice
          _tmp = apply(:_interpolated_expression)
          s = @result
          break if _tmp
          self.pos = _save2
          _tmp = apply(:_regex_seq)
          s = @result
          break if _tmp
          self.pos = _save2
          break
        end # end choice

        _ary << @result if _tmp
        break unless _tmp
      end
      _tmp = true
      @result = _ary
      values = @result
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string("/")
      unless _tmp
        self.pos = _save
        break
      end
      _ary = []
      while true
        _tmp = apply(:_regex_mods)
        _ary << @result if _tmp
        break unless _tmp
      end
      _tmp = true
      @result = _ary
      mods = @result
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin; regex(values,mods); end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_regex unless _tmp
    return _tmp
  end

  # interpolation_begin = "#{"
  def _interpolation_begin
    _tmp = match_string("\#{")
    set_failed_rule :_interpolation_begin unless _tmp
    return _tmp
  end

  # interpolation_end = "}"
  def _interpolation_end
    _tmp = match_string("}")
    set_failed_rule :_interpolation_end unless _tmp
    return _tmp
  end

  # interpolated_expression = interpolation_begin space? expression:expr space? interpolation_end {interpolation(expr)}
  def _interpolated_expression

    _save = self.pos
    while true # sequence
      _tmp = apply(:_interpolation_begin)
      unless _tmp
        self.pos = _save
        break
      end
      _save1 = self.pos
      _tmp = apply(:_space)
      unless _tmp
        _tmp = true
        self.pos = _save1
      end
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_expression)
      expr = @result
      unless _tmp
        self.pos = _save
        break
      end
      _save2 = self.pos
      _tmp = apply(:_space)
      unless _tmp
        _tmp = true
        self.pos = _save2
      end
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_interpolation_end)
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin; interpolation(expr); end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_interpolated_expression unless _tmp
    return _tmp
  end

  # array_empty = "[]" {array([])}
  def _array_empty

    _save = self.pos
    while true # sequence
      _tmp = match_string("[]")
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin; array([]); end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_array_empty unless _tmp
    return _tmp
  end

  # array_non_empty = "[" space? < expression_list:values > space? "]" {array(values)}
  def _array_non_empty

    _save = self.pos
    while true # sequence
      _tmp = match_string("[")
      unless _tmp
        self.pos = _save
        break
      end
      _save1 = self.pos
      _tmp = apply(:_space)
      unless _tmp
        _tmp = true
        self.pos = _save1
      end
      unless _tmp
        self.pos = _save
        break
      end
      _text_start = self.pos
      _tmp = apply(:_expression_list)
      values = @result
      if _tmp
        text = get_text(_text_start)
      end
      unless _tmp
        self.pos = _save
        break
      end
      _save2 = self.pos
      _tmp = apply(:_space)
      unless _tmp
        _tmp = true
        self.pos = _save2
      end
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string("]")
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin; array(values); end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_array_non_empty unless _tmp
    return _tmp
  end

  # array = (array_non_empty | array_empty)
  def _array

    _save = self.pos
    while true # choice
      _tmp = apply(:_array_non_empty)
      break if _tmp
      self.pos = _save
      _tmp = apply(:_array_empty)
      break if _tmp
      self.pos = _save
      break
    end # end choice

    set_failed_rule :_array unless _tmp
    return _tmp
  end

  # hash_sep = ":" space?
  def _hash_sep

    _save = self.pos
    while true # sequence
      _tmp = match_string(":")
      unless _tmp
        self.pos = _save
        break
      end
      _save1 = self.pos
      _tmp = apply(:_space)
      unless _tmp
        _tmp = true
        self.pos = _save1
      end
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_hash_sep unless _tmp
    return _tmp
  end

  # hash_lhs_symbol = identifier:name {symbol(name)}
  def _hash_lhs_symbol

    _save = self.pos
    while true # sequence
      _tmp = apply(:_identifier)
      name = @result
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin; symbol(name); end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_hash_lhs_symbol unless _tmp
    return _tmp
  end

  # hash_valid_lhs_exprs = (hash_braced | call | regex | array | identifier | constant | float | integer | string | symbol)
  def _hash_valid_lhs_exprs

    _save = self.pos
    while true # choice
      _tmp = apply(:_hash_braced)
      break if _tmp
      self.pos = _save
      _tmp = apply(:_call)
      break if _tmp
      self.pos = _save
      _tmp = apply(:_regex)
      break if _tmp
      self.pos = _save
      _tmp = apply(:_array)
      break if _tmp
      self.pos = _save
      _tmp = apply(:_identifier)
      break if _tmp
      self.pos = _save
      _tmp = apply(:_constant)
      break if _tmp
      self.pos = _save
      _tmp = apply(:_float)
      break if _tmp
      self.pos = _save
      _tmp = apply(:_integer)
      break if _tmp
      self.pos = _save
      _tmp = apply(:_string)
      break if _tmp
      self.pos = _save
      _tmp = apply(:_symbol)
      break if _tmp
      self.pos = _save
      break
    end # end choice

    set_failed_rule :_hash_valid_lhs_exprs unless _tmp
    return _tmp
  end

  # hash_lhs_expr = (hash_valid_lhs_exprs | expression_group)
  def _hash_lhs_expr

    _save = self.pos
    while true # choice
      _tmp = apply(:_hash_valid_lhs_exprs)
      break if _tmp
      self.pos = _save
      _tmp = apply(:_expression_group)
      break if _tmp
      self.pos = _save
      break
    end # end choice

    set_failed_rule :_hash_lhs_expr unless _tmp
    return _tmp
  end

  # hash_lhs = (hash_lhs_expr | hash_lhs_symbol)
  def _hash_lhs

    _save = self.pos
    while true # choice
      _tmp = apply(:_hash_lhs_expr)
      break if _tmp
      self.pos = _save
      _tmp = apply(:_hash_lhs_symbol)
      break if _tmp
      self.pos = _save
      break
    end # end choice

    set_failed_rule :_hash_lhs unless _tmp
    return _tmp
  end

  # hash_element = hash_lhs:key hash_sep expression:value {hash_element(key,value)}
  def _hash_element

    _save = self.pos
    while true # sequence
      _tmp = apply(:_hash_lhs)
      key = @result
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_hash_sep)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_expression)
      value = @result
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin; hash_element(key,value); end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_hash_element unless _tmp
    return _tmp
  end

  # hash_element_list = (hash_element (expression_list_sep hash_element)+ | hash_element)
  def _hash_element_list

    _save = self.pos
    while true # choice

      _save1 = self.pos
      while true # sequence
        _tmp = apply(:_hash_element)
        unless _tmp
          self.pos = _save1
          break
        end
        _save2 = self.pos

        _save3 = self.pos
        while true # sequence
          _tmp = apply(:_expression_list_sep)
          unless _tmp
            self.pos = _save3
            break
          end
          _tmp = apply(:_hash_element)
          unless _tmp
            self.pos = _save3
          end
          break
        end # end sequence

        if _tmp
          while true

            _save4 = self.pos
            while true # sequence
              _tmp = apply(:_expression_list_sep)
              unless _tmp
                self.pos = _save4
                break
              end
              _tmp = apply(:_hash_element)
              unless _tmp
                self.pos = _save4
              end
              break
            end # end sequence

            break unless _tmp
          end
          _tmp = true
        else
          self.pos = _save2
        end
        unless _tmp
          self.pos = _save1
        end
        break
      end # end sequence

      break if _tmp
      self.pos = _save
      _tmp = apply(:_hash_element)
      break if _tmp
      self.pos = _save
      break
    end # end choice

    set_failed_rule :_hash_element_list unless _tmp
    return _tmp
  end

  # hash_unbraced = hash_element_list:values {hash(values)}
  def _hash_unbraced

    _save = self.pos
    while true # sequence
      _tmp = apply(:_hash_element_list)
      values = @result
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin; hash(values); end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_hash_unbraced unless _tmp
    return _tmp
  end

  # hash_braced = "{" space? hash_element_list:values space? "}" {hash(values)}
  def _hash_braced

    _save = self.pos
    while true # sequence
      _tmp = match_string("{")
      unless _tmp
        self.pos = _save
        break
      end
      _save1 = self.pos
      _tmp = apply(:_space)
      unless _tmp
        _tmp = true
        self.pos = _save1
      end
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_hash_element_list)
      values = @result
      unless _tmp
        self.pos = _save
        break
      end
      _save2 = self.pos
      _tmp = apply(:_space)
      unless _tmp
        _tmp = true
        self.pos = _save2
      end
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string("}")
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin; hash(values); end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_hash_braced unless _tmp
    return _tmp
  end

  # hash_empty = "{" space? "}" {hash([])}
  def _hash_empty

    _save = self.pos
    while true # sequence
      _tmp = match_string("{")
      unless _tmp
        self.pos = _save
        break
      end
      _save1 = self.pos
      _tmp = apply(:_space)
      unless _tmp
        _tmp = true
        self.pos = _save1
      end
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string("}")
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin; hash([]); end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_hash_empty unless _tmp
    return _tmp
  end

  # hash = (hash_unbraced | hash_braced | hash_empty)
  def _hash

    _save = self.pos
    while true # choice
      _tmp = apply(:_hash_unbraced)
      break if _tmp
      self.pos = _save
      _tmp = apply(:_hash_braced)
      break if _tmp
      self.pos = _save
      _tmp = apply(:_hash_empty)
      break if _tmp
      self.pos = _save
      break
    end # end choice

    set_failed_rule :_hash unless _tmp
    return _tmp
  end

  # symbol_identifier = /[A-Za-z0-9_]+/
  def _symbol_identifier
    _tmp = scan(/\A(?-mix:[A-Za-z0-9_]+)/)
    set_failed_rule :_symbol_identifier unless _tmp
    return _tmp
  end

  # symbol_ident = < symbol_identifier > {symbol(text)}
  def _symbol_ident

    _save = self.pos
    while true # sequence
      _text_start = self.pos
      _tmp = apply(:_symbol_identifier)
      if _tmp
        text = get_text(_text_start)
      end
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin; symbol(text); end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_symbol_ident unless _tmp
    return _tmp
  end

  # symbol_string = string:value {symbol(value)}
  def _symbol_string

    _save = self.pos
    while true # sequence
      _tmp = apply(:_string)
      value = @result
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin; symbol(value); end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_symbol_string unless _tmp
    return _tmp
  end

  # symbol_glyph = < ("+" | "-" | "*" | "/" | "!" | "^" | "&" | "**") > {symbol(text)}
  def _symbol_glyph

    _save = self.pos
    while true # sequence
      _text_start = self.pos

      _save1 = self.pos
      while true # choice
        _tmp = match_string("+")
        break if _tmp
        self.pos = _save1
        _tmp = match_string("-")
        break if _tmp
        self.pos = _save1
        _tmp = match_string("*")
        break if _tmp
        self.pos = _save1
        _tmp = match_string("/")
        break if _tmp
        self.pos = _save1
        _tmp = match_string("!")
        break if _tmp
        self.pos = _save1
        _tmp = match_string("^")
        break if _tmp
        self.pos = _save1
        _tmp = match_string("&")
        break if _tmp
        self.pos = _save1
        _tmp = match_string("**")
        break if _tmp
        self.pos = _save1
        break
      end # end choice

      if _tmp
        text = get_text(_text_start)
      end
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin; symbol(text); end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_symbol_glyph unless _tmp
    return _tmp
  end

  # symbol_var = < ("@@" | "@") symbol_identifier > {symbol(text)}
  def _symbol_var

    _save = self.pos
    while true # sequence
      _text_start = self.pos

      _save1 = self.pos
      while true # sequence

        _save2 = self.pos
        while true # choice
          _tmp = match_string("@@")
          break if _tmp
          self.pos = _save2
          _tmp = match_string("@")
          break if _tmp
          self.pos = _save2
          break
        end # end choice

        unless _tmp
          self.pos = _save1
          break
        end
        _tmp = apply(:_symbol_identifier)
        unless _tmp
          self.pos = _save1
        end
        break
      end # end sequence

      if _tmp
        text = get_text(_text_start)
      end
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin; symbol(text); end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_symbol_var unless _tmp
    return _tmp
  end

  # symbol = ":" (symbol_ident | symbol_string | symbol_glyph | symbol_var)
  def _symbol

    _save = self.pos
    while true # sequence
      _tmp = match_string(":")
      unless _tmp
        self.pos = _save
        break
      end

      _save1 = self.pos
      while true # choice
        _tmp = apply(:_symbol_ident)
        break if _tmp
        self.pos = _save1
        _tmp = apply(:_symbol_string)
        break if _tmp
        self.pos = _save1
        _tmp = apply(:_symbol_glyph)
        break if _tmp
        self.pos = _save1
        _tmp = apply(:_symbol_var)
        break if _tmp
        self.pos = _save1
        break
      end # end choice

      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_symbol unless _tmp
    return _tmp
  end

  # comment = "#" < (!nl .)* > nl {comment(text)}
  def _comment

    _save = self.pos
    while true # sequence
      _tmp = match_string("#")
      unless _tmp
        self.pos = _save
        break
      end
      _text_start = self.pos
      while true

        _save2 = self.pos
        while true # sequence
          _save3 = self.pos
          _tmp = apply(:_nl)
          _tmp = _tmp ? nil : true
          self.pos = _save3
          unless _tmp
            self.pos = _save2
            break
          end
          _tmp = get_byte
          unless _tmp
            self.pos = _save2
          end
          break
        end # end sequence

        break unless _tmp
      end
      _tmp = true
      if _tmp
        text = get_text(_text_start)
      end
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_nl)
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin; comment(text); end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_comment unless _tmp
    return _tmp
  end

  # call_arg_splat = "*" expression:expr {call_argument_splat(expr)}
  def _call_arg_splat

    _save = self.pos
    while true # sequence
      _tmp = match_string("*")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_expression)
      expr = @result
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin; call_argument_splat(expr); end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_call_arg_splat unless _tmp
    return _tmp
  end

  # call_arg_expr = expression:expr {call_argument(expr)}
  def _call_arg_expr

    _save = self.pos
    while true # sequence
      _tmp = apply(:_expression)
      expr = @result
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin; call_argument(expr); end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_call_arg_expr unless _tmp
    return _tmp
  end

  # call_arg = (call_arg_expr | call_arg_splat)
  def _call_arg

    _save = self.pos
    while true # choice
      _tmp = apply(:_call_arg_expr)
      break if _tmp
      self.pos = _save
      _tmp = apply(:_call_arg_splat)
      break if _tmp
      self.pos = _save
      break
    end # end choice

    set_failed_rule :_call_arg unless _tmp
    return _tmp
  end

  # call_arg_sep = space? "," space?
  def _call_arg_sep

    _save = self.pos
    while true # sequence
      _save1 = self.pos
      _tmp = apply(:_space)
      unless _tmp
        _tmp = true
        self.pos = _save1
      end
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string(",")
      unless _tmp
        self.pos = _save
        break
      end
      _save2 = self.pos
      _tmp = apply(:_space)
      unless _tmp
        _tmp = true
        self.pos = _save2
      end
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_call_arg_sep unless _tmp
    return _tmp
  end

  # call_args = call_arg (call_arg_sep call_arg)+
  def _call_args

    _save = self.pos
    while true # sequence
      _tmp = apply(:_call_arg)
      unless _tmp
        self.pos = _save
        break
      end
      _save1 = self.pos

      _save2 = self.pos
      while true # sequence
        _tmp = apply(:_call_arg_sep)
        unless _tmp
          self.pos = _save2
          break
        end
        _tmp = apply(:_call_arg)
        unless _tmp
          self.pos = _save2
        end
        break
      end # end sequence

      if _tmp
        while true

          _save3 = self.pos
          while true # sequence
            _tmp = apply(:_call_arg_sep)
            unless _tmp
              self.pos = _save3
              break
            end
            _tmp = apply(:_call_arg)
            unless _tmp
              self.pos = _save3
            end
            break
          end # end sequence

          break unless _tmp
        end
        _tmp = true
      else
        self.pos = _save1
      end
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_call_args unless _tmp
    return _tmp
  end

  # call_without_args = < identifier:name > ("(" space? ")")? {call(name, [])}
  def _call_without_args

    _save = self.pos
    while true # sequence
      _text_start = self.pos
      _tmp = apply(:_identifier)
      name = @result
      if _tmp
        text = get_text(_text_start)
      end
      unless _tmp
        self.pos = _save
        break
      end
      _save1 = self.pos

      _save2 = self.pos
      while true # sequence
        _tmp = match_string("(")
        unless _tmp
          self.pos = _save2
          break
        end
        _save3 = self.pos
        _tmp = apply(:_space)
        unless _tmp
          _tmp = true
          self.pos = _save3
        end
        unless _tmp
          self.pos = _save2
          break
        end
        _tmp = match_string(")")
        unless _tmp
          self.pos = _save2
        end
        break
      end # end sequence

      unless _tmp
        _tmp = true
        self.pos = _save1
      end
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin; call(name, []); end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_call_without_args unless _tmp
    return _tmp
  end

  # call_with_braced_args = < identifier:name "(" space? call_args:args space? ")" > {call(text, args)}
  def _call_with_braced_args

    _save = self.pos
    while true # sequence
      _text_start = self.pos

      _save1 = self.pos
      while true # sequence
        _tmp = apply(:_identifier)
        name = @result
        unless _tmp
          self.pos = _save1
          break
        end
        _tmp = match_string("(")
        unless _tmp
          self.pos = _save1
          break
        end
        _save2 = self.pos
        _tmp = apply(:_space)
        unless _tmp
          _tmp = true
          self.pos = _save2
        end
        unless _tmp
          self.pos = _save1
          break
        end
        _tmp = apply(:_call_args)
        args = @result
        unless _tmp
          self.pos = _save1
          break
        end
        _save3 = self.pos
        _tmp = apply(:_space)
        unless _tmp
          _tmp = true
          self.pos = _save3
        end
        unless _tmp
          self.pos = _save1
          break
        end
        _tmp = match_string(")")
        unless _tmp
          self.pos = _save1
        end
        break
      end # end sequence

      if _tmp
        text = get_text(_text_start)
      end
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin; call(text, args); end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_call_with_braced_args unless _tmp
    return _tmp
  end

  # call_with_unbraced_args = < identifier:name space? call_args:args space? > {call(name, args)}
  def _call_with_unbraced_args

    _save = self.pos
    while true # sequence
      _text_start = self.pos

      _save1 = self.pos
      while true # sequence
        _tmp = apply(:_identifier)
        name = @result
        unless _tmp
          self.pos = _save1
          break
        end
        _save2 = self.pos
        _tmp = apply(:_space)
        unless _tmp
          _tmp = true
          self.pos = _save2
        end
        unless _tmp
          self.pos = _save1
          break
        end
        _tmp = apply(:_call_args)
        args = @result
        unless _tmp
          self.pos = _save1
          break
        end
        _save3 = self.pos
        _tmp = apply(:_space)
        unless _tmp
          _tmp = true
          self.pos = _save3
        end
        unless _tmp
          self.pos = _save1
        end
        break
      end # end sequence

      if _tmp
        text = get_text(_text_start)
      end
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin; call(name, args); end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_call_with_unbraced_args unless _tmp
    return _tmp
  end

  # call_without_block = (call_with_braced_args | call_with_unbraced_args | call_without_args)
  def _call_without_block

    _save = self.pos
    while true # choice
      _tmp = apply(:_call_with_braced_args)
      break if _tmp
      self.pos = _save
      _tmp = apply(:_call_with_unbraced_args)
      break if _tmp
      self.pos = _save
      _tmp = apply(:_call_without_args)
      break if _tmp
      self.pos = _save
      break
    end # end choice

    set_failed_rule :_call_without_block unless _tmp
    return _tmp
  end

  # call_with_block = call_without_block:call space? proc {call_with_block(call,nil)}
  def _call_with_block

    _save = self.pos
    while true # sequence
      _tmp = apply(:_call_without_block)
      call = @result
      unless _tmp
        self.pos = _save
        break
      end
      _save1 = self.pos
      _tmp = apply(:_space)
      unless _tmp
        _tmp = true
        self.pos = _save1
      end
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_proc)
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin; call_with_block(call,nil); end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_call_with_block unless _tmp
    return _tmp
  end

  # call = (call_with_block | call_without_block)
  def _call

    _save = self.pos
    while true # choice
      _tmp = apply(:_call_with_block)
      break if _tmp
      self.pos = _save
      _tmp = apply(:_call_without_block)
      break if _tmp
      self.pos = _save
      break
    end # end choice

    set_failed_rule :_call unless _tmp
    return _tmp
  end

  # expression_list_sep = space? "," space?
  def _expression_list_sep

    _save = self.pos
    while true # sequence
      _save1 = self.pos
      _tmp = apply(:_space)
      unless _tmp
        _tmp = true
        self.pos = _save1
      end
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string(",")
      unless _tmp
        self.pos = _save
        break
      end
      _save2 = self.pos
      _tmp = apply(:_space)
      unless _tmp
        _tmp = true
        self.pos = _save2
      end
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_expression_list_sep unless _tmp
    return _tmp
  end

  # expression_list = (expression (expression_list_sep expression)+ | expression)
  def _expression_list

    _save = self.pos
    while true # choice

      _save1 = self.pos
      while true # sequence
        _tmp = apply(:_expression)
        unless _tmp
          self.pos = _save1
          break
        end
        _save2 = self.pos

        _save3 = self.pos
        while true # sequence
          _tmp = apply(:_expression_list_sep)
          unless _tmp
            self.pos = _save3
            break
          end
          _tmp = apply(:_expression)
          unless _tmp
            self.pos = _save3
          end
          break
        end # end sequence

        if _tmp
          while true

            _save4 = self.pos
            while true # sequence
              _tmp = apply(:_expression_list_sep)
              unless _tmp
                self.pos = _save4
                break
              end
              _tmp = apply(:_expression)
              unless _tmp
                self.pos = _save4
              end
              break
            end # end sequence

            break unless _tmp
          end
          _tmp = true
        else
          self.pos = _save2
        end
        unless _tmp
          self.pos = _save1
        end
        break
      end # end sequence

      break if _tmp
      self.pos = _save
      _tmp = apply(:_expression)
      break if _tmp
      self.pos = _save
      break
    end # end choice

    set_failed_rule :_expression_list unless _tmp
    return _tmp
  end

  # expression_group = "(" space? expression:expr space? ")" {expression_group(expr)}
  def _expression_group

    _save = self.pos
    while true # sequence
      _tmp = match_string("(")
      unless _tmp
        self.pos = _save
        break
      end
      _save1 = self.pos
      _tmp = apply(:_space)
      unless _tmp
        _tmp = true
        self.pos = _save1
      end
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_expression)
      expr = @result
      unless _tmp
        self.pos = _save
        break
      end
      _save2 = self.pos
      _tmp = apply(:_space)
      unless _tmp
        _tmp = true
        self.pos = _save2
      end
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string(")")
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin; expression_group(expr); end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_expression_group unless _tmp
    return _tmp
  end

  # expression_item = (hash | call | regex | array | identifier | constant | float | integer | string | symbol)
  def _expression_item

    _save = self.pos
    while true # choice
      _tmp = apply(:_hash)
      break if _tmp
      self.pos = _save
      _tmp = apply(:_call)
      break if _tmp
      self.pos = _save
      _tmp = apply(:_regex)
      break if _tmp
      self.pos = _save
      _tmp = apply(:_array)
      break if _tmp
      self.pos = _save
      _tmp = apply(:_identifier)
      break if _tmp
      self.pos = _save
      _tmp = apply(:_constant)
      break if _tmp
      self.pos = _save
      _tmp = apply(:_float)
      break if _tmp
      self.pos = _save
      _tmp = apply(:_integer)
      break if _tmp
      self.pos = _save
      _tmp = apply(:_string)
      break if _tmp
      self.pos = _save
      _tmp = apply(:_symbol)
      break if _tmp
      self.pos = _save
      break
    end # end choice

    set_failed_rule :_expression_item unless _tmp
    return _tmp
  end

  # expression = (expression_group | expression_item)
  def _expression

    _save = self.pos
    while true # choice
      _tmp = apply(:_expression_group)
      break if _tmp
      self.pos = _save
      _tmp = apply(:_expression_item)
      break if _tmp
      self.pos = _save
      break
    end # end choice

    set_failed_rule :_expression unless _tmp
    return _tmp
  end

  # statements = statement+
  def _statements
    _save = self.pos
    _tmp = apply(:_statement)
    if _tmp
      while true
        _tmp = apply(:_statement)
        break unless _tmp
      end
      _tmp = true
    else
      self.pos = _save
    end
    set_failed_rule :_statements unless _tmp
    return _tmp
  end

  # statement_end = (nl | eof)
  def _statement_end

    _save = self.pos
    while true # choice
      _tmp = apply(:_nl)
      break if _tmp
      self.pos = _save
      _tmp = apply(:_eof)
      break if _tmp
      self.pos = _save
      break
    end # end choice

    set_failed_rule :_statement_end unless _tmp
    return _tmp
  end

  # statement = (expression | comment) statement_end
  def _statement

    _save = self.pos
    while true # sequence

      _save1 = self.pos
      while true # choice
        _tmp = apply(:_expression)
        break if _tmp
        self.pos = _save1
        _tmp = apply(:_comment)
        break if _tmp
        self.pos = _save1
        break
      end # end choice

      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_statement_end)
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_statement unless _tmp
    return _tmp
  end

  # root = statements
  def _root
    _tmp = apply(:_statements)
    set_failed_rule :_root unless _tmp
    return _tmp
  end

  Rules = {}
  Rules[:_eof] = rule_info("eof", "!.")
  Rules[:_space] = rule_info("space", "(\" \" | \"\\t\")")
  Rules[:_nl] = rule_info("nl", "(\"\\n\" | \"\" | \"\\n\" | \"\\n\")")
  Rules[:_keywords] = rule_info("keywords", "(\"module\" | \"class\" | \"if\" | \"else\" | \"elsif\" | \"unless\")")
  Rules[:_rejected] = rule_info("rejected", "(\"do\" | \"and\" | \"or\" | \"not\" | \"return\" | \"proc\" | \"lambda\")")
  Rules[:_module] = rule_info("module", "\"module\"")
  Rules[:_class] = rule_info("class", "\"class\"")
  Rules[:_if] = rule_info("if", "\"if\"")
  Rules[:_else] = rule_info("else", "\"else\"")
  Rules[:_elsif] = rule_info("elsif", "\"elsif\"")
  Rules[:_unless] = rule_info("unless", "\"unless\"")
  Rules[:_raise] = rule_info("raise", "(\"raise\" | \"o_O\")")
  Rules[:_rescue] = rule_info("rescue", "\"rescue\"")
  Rules[:_ensure] = rule_info("ensure", "\"ensure\"")
  Rules[:_proc] = rule_info("proc", "\"&>\"")
  Rules[:_identifier] = rule_info("identifier", "/[a-z_][a-zA-Z0-9_]*/")
  Rules[:_constant_name] = rule_info("constant_name", "/([A-Z][a-zA-Z0-9_]+)/")
  Rules[:_constant_sep] = rule_info("constant_sep", "\"::\"")
  Rules[:_constant_with_sep] = rule_info("constant_with_sep", "constant_sep constant_name")
  Rules[:_constant] = rule_info("constant", "< (constant_name constant_with_sep+ | constant_with_sep+ | constant_name) > {constant(text)}")
  Rules[:_integer_octal] = rule_info("integer_octal", "/(0[1-9][0-9]*)/")
  Rules[:_integer_decimal] = rule_info("integer_decimal", "/([1-9][0-9]*)/")
  Rules[:_integer_zero] = rule_info("integer_zero", "\"0\"")
  Rules[:_integer_hex] = rule_info("integer_hex", "/(0x[0-9a-fA-F]+)/")
  Rules[:_integer_binary] = rule_info("integer_binary", "/(0b[01]+)/")
  Rules[:_integer] = rule_info("integer", "< (integer_octal | integer_decimal | integer_hex | integer_binary | integer_zero) > {integer(text)}")
  Rules[:_float] = rule_info("float", "< /([0-9]+\\.[0-9]+)/ > {float(text)}")
  Rules[:_single_tick_string] = rule_info("single_tick_string", "\"'\" simple_string_seq:value \"'\" {string([value])}")
  Rules[:_simple_string_seq] = rule_info("simple_string_seq", "< /(\\\\'|[^'])/* > {simple_string(text)}")
  Rules[:_string_seq] = rule_info("string_seq", "< /[^\\\\\"]+/ > {simple_string(text)}")
  Rules[:_double_tick_string] = rule_info("double_tick_string", "\"\\\"\" (interpolated_expression:s | string_seq:s)*:values \"\\\"\" {string(values)}")
  Rules[:_string] = rule_info("string", "(single_tick_string | double_tick_string)")
  Rules[:_regex_seq] = rule_info("regex_seq", "< /[^\\\\\\/]+/ > {regex_seq(text)}")
  Rules[:_regex_mods] = rule_info("regex_mods", "(\"i\" | \"m\" | \"x\" | \"o\")")
  Rules[:_regex] = rule_info("regex", "\"/\" (interpolated_expression:s | regex_seq:s)*:values \"/\" regex_mods*:mods {regex(values,mods)}")
  Rules[:_interpolation_begin] = rule_info("interpolation_begin", "\"\#{\"")
  Rules[:_interpolation_end] = rule_info("interpolation_end", "\"}\"")
  Rules[:_interpolated_expression] = rule_info("interpolated_expression", "interpolation_begin space? expression:expr space? interpolation_end {interpolation(expr)}")
  Rules[:_array_empty] = rule_info("array_empty", "\"[]\" {array([])}")
  Rules[:_array_non_empty] = rule_info("array_non_empty", "\"[\" space? < expression_list:values > space? \"]\" {array(values)}")
  Rules[:_array] = rule_info("array", "(array_non_empty | array_empty)")
  Rules[:_hash_sep] = rule_info("hash_sep", "\":\" space?")
  Rules[:_hash_lhs_symbol] = rule_info("hash_lhs_symbol", "identifier:name {symbol(name)}")
  Rules[:_hash_valid_lhs_exprs] = rule_info("hash_valid_lhs_exprs", "(hash_braced | call | regex | array | identifier | constant | float | integer | string | symbol)")
  Rules[:_hash_lhs_expr] = rule_info("hash_lhs_expr", "(hash_valid_lhs_exprs | expression_group)")
  Rules[:_hash_lhs] = rule_info("hash_lhs", "(hash_lhs_expr | hash_lhs_symbol)")
  Rules[:_hash_element] = rule_info("hash_element", "hash_lhs:key hash_sep expression:value {hash_element(key,value)}")
  Rules[:_hash_element_list] = rule_info("hash_element_list", "(hash_element (expression_list_sep hash_element)+ | hash_element)")
  Rules[:_hash_unbraced] = rule_info("hash_unbraced", "hash_element_list:values {hash(values)}")
  Rules[:_hash_braced] = rule_info("hash_braced", "\"{\" space? hash_element_list:values space? \"}\" {hash(values)}")
  Rules[:_hash_empty] = rule_info("hash_empty", "\"{\" space? \"}\" {hash([])}")
  Rules[:_hash] = rule_info("hash", "(hash_unbraced | hash_braced | hash_empty)")
  Rules[:_symbol_identifier] = rule_info("symbol_identifier", "/[A-Za-z0-9_]+/")
  Rules[:_symbol_ident] = rule_info("symbol_ident", "< symbol_identifier > {symbol(text)}")
  Rules[:_symbol_string] = rule_info("symbol_string", "string:value {symbol(value)}")
  Rules[:_symbol_glyph] = rule_info("symbol_glyph", "< (\"+\" | \"-\" | \"*\" | \"/\" | \"!\" | \"^\" | \"&\" | \"**\") > {symbol(text)}")
  Rules[:_symbol_var] = rule_info("symbol_var", "< (\"@@\" | \"@\") symbol_identifier > {symbol(text)}")
  Rules[:_symbol] = rule_info("symbol", "\":\" (symbol_ident | symbol_string | symbol_glyph | symbol_var)")
  Rules[:_comment] = rule_info("comment", "\"\#\" < (!nl .)* > nl {comment(text)}")
  Rules[:_call_arg_splat] = rule_info("call_arg_splat", "\"*\" expression:expr {call_argument_splat(expr)}")
  Rules[:_call_arg_expr] = rule_info("call_arg_expr", "expression:expr {call_argument(expr)}")
  Rules[:_call_arg] = rule_info("call_arg", "(call_arg_expr | call_arg_splat)")
  Rules[:_call_arg_sep] = rule_info("call_arg_sep", "space? \",\" space?")
  Rules[:_call_args] = rule_info("call_args", "call_arg (call_arg_sep call_arg)+")
  Rules[:_call_without_args] = rule_info("call_without_args", "< identifier:name > (\"(\" space? \")\")? {call(name, [])}")
  Rules[:_call_with_braced_args] = rule_info("call_with_braced_args", "< identifier:name \"(\" space? call_args:args space? \")\" > {call(text, args)}")
  Rules[:_call_with_unbraced_args] = rule_info("call_with_unbraced_args", "< identifier:name space? call_args:args space? > {call(name, args)}")
  Rules[:_call_without_block] = rule_info("call_without_block", "(call_with_braced_args | call_with_unbraced_args | call_without_args)")
  Rules[:_call_with_block] = rule_info("call_with_block", "call_without_block:call space? proc {call_with_block(call,nil)}")
  Rules[:_call] = rule_info("call", "(call_with_block | call_without_block)")
  Rules[:_expression_list_sep] = rule_info("expression_list_sep", "space? \",\" space?")
  Rules[:_expression_list] = rule_info("expression_list", "(expression (expression_list_sep expression)+ | expression)")
  Rules[:_expression_group] = rule_info("expression_group", "\"(\" space? expression:expr space? \")\" {expression_group(expr)}")
  Rules[:_expression_item] = rule_info("expression_item", "(hash | call | regex | array | identifier | constant | float | integer | string | symbol)")
  Rules[:_expression] = rule_info("expression", "(expression_group | expression_item)")
  Rules[:_statements] = rule_info("statements", "statement+")
  Rules[:_statement_end] = rule_info("statement_end", "(nl | eof)")
  Rules[:_statement] = rule_info("statement", "(expression | comment) statement_end")
  Rules[:_root] = rule_info("root", "statements")
  # :startdoc:
end
