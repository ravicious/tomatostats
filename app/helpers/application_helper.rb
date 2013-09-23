module ApplicationHelper
  def sidebar(&block)
    content_tag(:div, class: "well sidebar-nav") do
      yield
    end
  end

  def glyph(name, white: false, space: true)
    content_tag(:i, nil, class: "icon-#{name}#{" icon-white" if white}") + (space ? " " : "")
  end
end
