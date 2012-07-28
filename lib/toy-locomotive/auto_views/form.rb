module ToyLocomotive::AutoViews
  def auto_form_for args
    if block_given?
      form = ToyLocomotive::AutoViews::AutoForm.new
      yield(form)
    end
    form_for args do |f|
      arg = args.class == Array ? args.last : args
      klass = arg.class
      html = ''
      klass.attributes.each do |attr|
        next if attr.skip_table_column?
        if attr.to_helper == :hidden_field
          html += f.send :hidden_field, attr.to_table_column
        else
          html += "<fieldset class=\"#{attr.to_table_column}\">"
          if attr.to_helper == :check_box
            html += f.send attr.to_helper, attr.to_table_column
            html += f.label attr.to_table_column
          elsif attr.to_helper == :select
            html += f.label attr.to_table_column
            html += f.send attr.to_helper, attr.to_table_column, attr._options
          else
            html += f.label attr.to_table_column
            html += f.send attr.to_helper, attr.to_table_column
          end
          html += "</fieldset>"
        end
      end
      html += '<div class="actions">'
      puts "+++++++++++++++++++"
      puts form._actions if block_given?
      puts "+++++++++++++++++++"
      html += f.submit
      html += link_to "Cancel", root_path
      html += '</div>'
      raw html
    end.to_s
  end
end

class ToyLocomotive::AutoViews::AutoForm
  attr_accessor :_actions

  def actions &blk
    @_actions = blk
  end

  def _actions
    @_actions.call.to_s
  end
end

ActionView::Base.send :include, ToyLocomotive::AutoViews
