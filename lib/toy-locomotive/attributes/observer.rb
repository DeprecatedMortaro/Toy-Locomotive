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
      add_attribute attribute
      update_attribute attribute
    end

    def add_attribute attribute
      unless @model.column_names.include? attribute.column.to_s
        Class.new(ActiveRecord::Migration).add_column @model.table_name.to_sym, attribute.column, attribute._as
      end
    end

    def update_attribute attribute
      column = @model.columns.select{|c| c.name == attribute.column.to_s}.first
      if column && column.type != attribute._as
        Class.new(ActiveRecord::Migration).change_column @model.table_name, attribute.column, attribute._as
      end
    end

  end

end
