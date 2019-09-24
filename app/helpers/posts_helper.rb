module PostsHelper
  def clean_links html
    html.gsub!(/\<a href=["'](.*?)["']\>(.*?)\<\/a\>/mi, '<a href="\1" rel="nofollow ugc">\2</a>')
    html.html_safe
  end
end
