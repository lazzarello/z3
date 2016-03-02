module Z3
  class IntSort < Sort
    def initialize
      super LowLevel.mk_int_sort
    end

    def value_class
      IntValue
    end

    def from_const(val)
      if val.is_a?(Integer)
        new(LowLevel.mk_numeral(val.to_s, self))
      else
        raise Z3::Exception, "Cannot convert #{val.class} to #{self.class}"
      end
    end

    class <<self
      public :new
    end
  end
end
