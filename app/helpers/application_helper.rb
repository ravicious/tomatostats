module ApplicationHelper
  def sidebar(&block)
    content_tag(:div, class: "well sidebar-nav") do
      yield
    end
  end
end
