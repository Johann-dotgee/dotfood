module ApplicationHelper

  def li_list links = [], icons = [], texts = []

    capture_haml do
      for i in 0..links.count-1
        class_name = current_page?(links[i]) ? 'active' : ''

        haml_tag(:li, :class => class_name) do
          haml_tag(:a, :href => links[i]) do
            haml_tag(:i, :class => "icon-#{icons[i]}")
            haml_tag(:span, texts[i])
          end
        end

      end
    end
  end
  

  def li_nav link_path, icon, link_text
    class_name = current_page?(link_path) ? 'active' : ''

      capture_haml do
        haml_tag(:li, :class => class_name) do
          haml_tag(:a, :href => link_path) do
            haml_tag(:i, :class => "icon-#{icon}")
            haml_tag(:span, link_text)
          end
        end
      end

  end

end
