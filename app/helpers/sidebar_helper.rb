module SidebarHelper
  def sidebar(title: false, &block)
    content_tag(:div, class: 'panel panel-default') do
      sidebar_title(title) + sidebar_body{yield}
    end
  end

  def sidebar_title(title)
    if title
      content_tag(:div, class: 'panel-heading') do
        content_tag(:h3, title, class: 'panel-title')
      end
    else
      "".html_safe
    end
  end

  def sidebar_body(&block)
    content_tag(:div, class: 'panel-body') do
      yield
    end
  end
end
