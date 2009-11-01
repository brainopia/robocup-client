module Symbolic
  @enabled = false
  class << self
    def enabled?
      @enabled
    end

    def enabled=(enable_flag)
      if enable_flag && !@enabled
        enable
      elsif !enable_flag && @enabled
        disable
      end
    end

    def aliases
      { :* => :non_symbolic_multiplication,
        :+ => :non_symbolic_addition }
    end

    def math_operations
      [:cos, :sin]
    end

    private

    def numerical_context(&proc)
      [Fixnum, Bignum, Float].each do |klass|
        klass.class_eval &proc
      end
    end

    def enable
      @enabled = true
      numerical_context do
        Symbolic.aliases.each do |standard_operation, non_symbolic_operation|
          alias_method non_symbolic_operation, standard_operation
        end # aliases.each

        def *(value)
          if value.is_a?(Operatable)
            return self if self == 0
            return value if self == 1
            Expression.new self, value, '*'
          else
            non_symbolic_multiplication(value)
          end
        end

        def +(value)
          return non_symbolic_addition(value) unless value.is_a? Operatable
          return value if self == 0
          Expression.new self, value, '+'
        end
      end # numerical_context

      math_operations.each do |operation|
        Math.module_eval <<-CODE
          class << self
            alias non_symbolic_#{operation} #{operation}

            def #{operation}(value)
              if value.is_a? Operatable
                Symbolic::Method.new value, :#{operation}
              else
                non_symbolic_#{operation} value
              end
            end
          end
        CODE
      end
    end # enable

    def disable
      @enabled = false
      numerical_context do
        Symbolic.aliases.each do |standard_operation, non_symbolic_operation|
          alias_method standard_operation, non_symbolic_operation
          remove_method non_symbolic_operation
        end
      end

      Math.module_eval do
        class << self
          Symbolic.math_operations.each do |operation|
            non_symbolic_operation = "non_symbolic_#{operation}"
            alias_method operation, non_symbolic_operation
            remove_method non_symbolic_operation
          end
        end
      end
    end # disable
  end # class << self

  class Operatable
    def -@
      UnaryMinus.new self
    end

    def *(value)
      return value if value == 0
      return self if value == 1
      Expression.new self, variable, '*'
    end

    def +(value)
      return self if value == 0
      Expression.new self, variable, '+'
    end

    def -(value)
      return self if value == 0
      Expression.new self, variable, '-'
    end
  end # Operations

  class Variable < Operatable
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

  class Expression < Operatable
    def initialize(var1, var2, operation)
      @var1, @var2, @operation = var1, var2, operation
    end

    def to_s
      "(#{@var1}#{@operation}#{@var2})"
    end

    def value
      if undefined_variables.empty?
        value_of(@var1).send @operation, value_of(@var2)
      end
    end

    def undefined_variables
      (undefined_variables_of(@var1) + undefined_variables_of(@var2)).uniq
    end

    private

    def undefined_variables_of(variable)
      variable.is_a?(Operatable) ? variable.undefined_variables : []
    end

    def value_of(variable)
      variable.is_a?(Operatable) ? variable.value : variable
    end
  end

  class Method < Operatable
    def initialize(variable, operation)
      @variable, @operation = variable, operation
    end

    def to_s
      "#{@operation}(#{@variable})"
    end

    def value
      Math.send @operation, @variable.value if undefined_variables.empty?
    end

    def undefined_variables
      @variable.undefined_variables
    end
  end

  class UnaryMinus < Operatable
    def initialize(variable)
      @variable = variable
    end

    def to_s
      "(-#{@variable})"
    end

    def value
      -@variable.value if undefined_variables.empty?
    end

    def undefined_variables
      @variable.undefined_variables
    end
  end
end

module Kernel
  def var(value=nil)
    Symbolic::Variable.new value
  end

  def symbolic
    Symbolic.enabled = true
    yield
    Symbolic.enabled = false
  end
end