module SExpressionParser
  remove_const :Value
  remove_const :Values
  remove_const :Parser
  Value = whitespace.many_ >> alt(Quoted, List, String, Number, Symbol) << whitespace.many_
  Values = Value.many
  Parser = Values << eof
end

module RParsec::Parsers
  def integer(expected='integer expected')
    regexp(/[-+]?\d+(?!\w)/, expected)
  end
  
  def number(expected='number expected')
    regexp(/[-+]?\d+(\.\d+)?/, expected)
  end
end