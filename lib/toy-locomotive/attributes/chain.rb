module ToyLocomotive::Attributes
  class AttributeChain

    attr_accessor :column, :parent, :_as, :_helper

    def initialize column, parent
      @column = column
      @parent = parent
      @_as = :string
    end

    def as value
      @_as = value
      self
    end

    def presence bool
      parent.send :validates_presence_of, column
      self
    end

    def uniqueness value
      return parent.send :validates_uniqueness_of, column if value == true
      parent.send :validates_uniqueness_of, column, {scope: value}
      self
    end

    def helper value
      @_helper = value
      self
    end

    def to_helper
      return @_helper if @_helper
      return :text_area if @_as == :text
      return :hidden_field if @column == :id || @column.to_s[-3..-1] == '_id'
      return :check_box if @column == :id || @column._as == :boolean
      :text_field
    end

  end
end
