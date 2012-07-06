module ApplicationHelper

  def li_list links = [], icons = [], texts = []

    s = ""

    for i in 0..links.count-1
      class_name = current_page?(links[i]) ? 'active' : ''

      icon = content_tag(:i, " ", :class => "icon-#{icons[i]}")
      span = content_tag(:span, texts[i])
      content_for_link = icon + span
      content_for_li = content_tag(:a, content_for_link, :href => links[i]) 
      s+=content_tag(:li, content_for_li, :class => class_name)
    end
    s.html_safe
  end

  def li_nav link_path, icon, link_text
    class_name = current_page?(link_path) ? 'active' : ''

      i = content_tag(:i, " ", :class => "icon-#{icon}")
      span = content_tag(:span, link_text)
      content_for_link = i + span
      content_for_li = content_tag(:a, content_for_link, :href => link_path) 
      content_tag(:li, content_for_li, :class => class_name)
      # link_to link_path do
      #   tag(:i, :class => "icon-#{icon}")
      #   content_tag(:span, link_text)
      #end

  end

end
