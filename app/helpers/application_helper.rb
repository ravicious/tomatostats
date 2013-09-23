module ApplicationHelper
  def glyph(name, white: false, space: true)
    content_tag(:i, nil, class: "icon-#{name}#{" icon-white" if white}") + (space ? " " : "")
  end
end
