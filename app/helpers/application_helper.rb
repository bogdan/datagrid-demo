module ApplicationHelper
 def file_source(path, type = "ruby")
   content_tag(:pre, content_tag(:code, File.read("#{Rails.root}/app/#{path}")), :class => "sh_#{type}")
 end
end
