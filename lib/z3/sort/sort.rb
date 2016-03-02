module Z3
  class Sort
    attr_reader :_sort
    def initialize(_sort)
      @_sort = _sort
    end

    def ==(other)
      other.is_a?(Sort) and @_sort == other._sort
    end

    def to_s
      LowLevel.sort_to_string(self)
    end

    def inspect
      "Z3::Sort<#{to_s}>"
    end

    def var(name)
      new(
        Z3::LowLevel.mk_const(
          Z3::LowLevel.mk_string_symbol(name),
          self,
        )
      )
    end

    # We pretend to be a class, sort of
    def new(_ast)
      value_class.new(_ast, self)
    end

    def value_class
      raise "SubclassResponsibility"
    end

    class <<self
      private :new
    end
  end
end
