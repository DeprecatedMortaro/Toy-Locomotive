module ToyLocomotive::Attributes
  class AttributeChain

    attr_accessor :column, :parent, :_as, :_helper, :_options

    def initialize column, parent
      @column = column
      @parent = parent
      @_as = :string
    end

    def as value
      @_as = value
      @parent.send @_as, @column if [:has_many, :has_and_belongs_to_many, :has_one, :belongs_to].include? @_as
      self
    end

    def options value=nil
      @_options = options if value
      @_options
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

    def to_table_column
      return nil if skip_table_column?
      return :"#{@column}_id" if @_as == :belongs_to
      @column
    end

    def to_table_type
      return nil if skip_table_column?
      return :integer if @_as == :belongs_to
      @_as
    end

    def skip_table_column?
      [:has_many, :has_and_belongs_to_many, :has_one].include? @_as
    end

    def to_helper
      return @_helper if @_helper
      return :text_area if @_as == :text
      return :hidden_field if @column == :id || @_as == :belongs_to
      return :check_box if @_as == :boolean
      return :date_select if @_as == :date
      :text_field
    end

  end
end
