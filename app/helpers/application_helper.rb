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

  def li_dropdown_nav links = [], icons = [], texts = []
    capture_haml do
      active = false
      links.each do |link|
        active = true if current_page? link
      end
      class_name = active ? 'active' : ''
      haml_tag(:li, :class => "#{class_name} dropdown") do
        haml_tag(:a, :href => "#", :class => "dropdown-toggle", "data-toggle" => "dropdown") do
          haml_tag(:i, :class => "icon-#{icons[0]}")
          haml_tag(:span, texts[0])
          haml_tag(:b, :class => "caret")
        end
        haml_tag(:ul, :class => "dropdown-menu") do
          for i in 1..icons.count-1
            haml_tag(:a, :href => links[(i.to_i-1)]) do
              haml_tag(:i, :class => "icon-#{icons[i]}")
              haml_tag(:span, texts[i])
            end
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
