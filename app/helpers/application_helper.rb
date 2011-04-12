module ApplicationHelper
  def strip_words(content, length = 30, ext = "...")
    content = content.gsub("&nbsp;", "").gsub(/^ /, "")
    content = strip_tags(content)
    content.split[0..(length-1)].join(" ") + ext
  end
end
