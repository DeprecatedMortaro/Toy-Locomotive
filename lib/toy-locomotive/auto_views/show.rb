module ToyLocomotive::AutoViews
  def auto_show_for args
    arg = args.class == Array ? args.last : args
    klass = arg.class
    html = '<div class="attributes-show">'
    klass.attributes.each do |attr|
      html += '<div class="attr-set">'
        html += '<div class="attr-label">'+attr.column.to_s+'</div>'
        html += '<div class="attr-content">'+arg.send(attr.column).to_s+'</div>'
      html += '</div>'
    end
    html += '<div class="actions">'
      html += link_to "Editar", {:action => :edit}, {:class => :edit}
      html += link_to "Deletar", {:action => :destroy}, {:class => :destroy, :method => :delete, :confirm => "Tem certeza?"}
    html += '</div>'
    html += '</div>'
    raw html
  end
end
