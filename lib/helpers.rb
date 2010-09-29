helpers do
  
  def param_table(params)
    params.delete 'controller'
    params.delete 'action'

    html = "<table cellspacing=\"0\">"
    params.each do |k,v|
      if v.is_a?(BSON::OrderedHash)
        html << %Q{ <tr class=\"key_for_nested_value\">
                      <td class=\"key\">:#{k}</td>
                      <td class=\"value\"></td>
                    </tr>
                    <tr class=\"nested\">
                      <td colspan=\"2\">#{param_table(v)}</td>
                    </tr>
                  }
      else
        html << %Q{ <tr>
                      <td class=\"key\">:#{k}</td>
                      <td class=\"value\">=> #{v.inspect}</td>
                    </tr>
                  }
      end
    end
    html << "</table>"
  end

  def link_to_entry(entry, text)
    href = "/entry/#{entry['_id']}"
    "<a href=\"#{href}\" data-remote=\"true\">#{text}</a>"
  end

  def link_to_page(page, text)
    href = "/page/#{page}?#{request.query_string}"
    "<a href=\"#{href}\" data-remote=\"true\">#{text}</a>"
  end

end
