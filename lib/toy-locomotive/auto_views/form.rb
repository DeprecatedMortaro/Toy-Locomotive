module ToyLocomotive::AutoViews
  def auto_form_for args
    form_for args do |f|
      arg = args.class == Array ? args.last : args
      klass = arg.class
      html = ''
      klass.attributes.each do |attr|
        next if attr.skip_table_column?
        if attr.to_helper == :hidden_field
          html += f.send :hidden_field, attr.to_table_column
        else
          html += "<fieldset>"
          html += f.label attr.to_table_column
          html += f.send attr.to_helper, attr.to_table_column
          html += "</fieldset>"
        end
      end
      html += '<div class="actions">'
      html += f.submit
      html += link_to "Cancel", root_path
      html += '</div>'
      raw html
    end.to_s
  end
end

ActionView::Base.send :include, ToyLocomotive::AutoViews
