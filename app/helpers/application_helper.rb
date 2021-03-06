module ApplicationHelper
  def glyph(name, white: false, space: true)
    content_tag(:span, nil, class: "glyphicon glyphicon-#{name}#{" icon-white" if white}") + (space ? " " : "")
  end

  def flash_class(level)
    case level
    when :notice then "alert alert-info"
    when :success then "alert alert-success"
    when :error then "alert alert-warning"
    when :alert then "alert alert-warning"
    else "alert alert-info"
    end
  end
end
