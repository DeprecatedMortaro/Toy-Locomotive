module ToyLocomotive
  class AttributeObserver

    attr_accessor :attribute

    def initialize model
      @model = model
      unless ActiveRecord::Base.connection.table_exists? @model.table_name
        Class.new(ActiveRecord::Migration).create_table(@model.table_name.to_sym) do |t|
          t.timestamps
        end
      end
      @model.attributes.each do |attribute|
        set_attribute(attribute)
        @model.attr_accessible attribute.column
      end
      @model.reset_column_information
    end

    def set_attribute attribute
      return if skip_table_column?
      add_attribute attribute
      update_attribute attribute
    end

    def add_attribute attribute
      unless @model.column_names.include? attribute.to_table_column.to_s
        Class.new(ActiveRecord::Migration).add_column @model.table_name.to_sym, attribute.to_table_column, attribute.to_table_type
      end
    end

    def update_attribute attribute
      column = @model.columns.select{|c| c.name == attribute.to_table_column.to_s}.first
      if column && column.type != attribute.to_table_type
        Class.new(ActiveRecord::Migration).change_column @model.table_name, attribute.to_table_column, attribute.to_table_type
      end
    end

  end

end
