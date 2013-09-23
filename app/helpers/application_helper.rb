module ApplicationHelper
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
      yield block
    end
  end

  def glyph(name, white: false, space: true)
    content_tag(:i, nil, class: "icon-#{name}#{" icon-white" if white}") + (space ? " " : "")
  end
end
