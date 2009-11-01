module Symbolic
  module Operations
    def *(variable)
      Expression.new self, variable, '*'
    end

    def +(variable)
      Expression.new self, variable, '+'
    end
  end

  class Variable
    include Operations
    attr_accessor :value

    @@index = 0

    def initialize(value)
      @@index += 1
      @name = "var#{@@index}"
      @value = value
    end

    def to_s
      @name
    end

    def undefined_variables
      @value ? [] : [self]
    end
  end

  class Expression
    include Operations

    def initialize(var1, var2, operation)
      @var1, @var2, @operation = var1, var2, operation
    end

    def to_s
      "(#{@var1}#{@operation}#{@var2})"
    end

    def value
      if undefined_variables.empty?
        @var1.value.send @operation, @var2.value
      end
    end

    def undefined_variables
      (@var1.undefined_variables + @var2.undefined_variables).uniq
    end
  end
end

module Kernel
  def var(value=nil)
    Symbolic::Variable.new value
  end
end