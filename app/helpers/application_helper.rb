module ApplicationHelper
  require 'digest/md5' #gravatar_url_for

  def strip_words(content, length = 30, ext = "...")
    content = content.gsub("&nbsp;", "").gsub(/^ /, "")
    content = strip_tags(content)
    content.split[0..(length-1)].join(" ") + ext
  end

  def breadcrumb
    li_1 = content_tag(:li, "/") + content_tag(:li, t("controllers.#{controller_name}.actions.#{action_name}").downcase) unless action_name == "index"
    li_0 = content_tag(:li, link_to("admin", admin_root_url)) + 
           content_tag(:li, "/") + 
           content_tag(:li, link_to(t("controllers.#{controller_name}.name").downcase, {:action => "index"}))
    ul_tag = content_tag(:ul, li_0 + li_1)
    nav0   = content_tag(:div, content_tag(:h3, t("you_are_here")+":") + ul_tag, :class => "bcnav-right clear")
    nav1   = content_tag(:div, nav0, :class => "bcnav-left")
    nav    = content_tag(:div, nav1, :class => "bcnav")
    nav
  end

  def show_notice
    content_tag(:div, flash[:notice], :class => "notice") unless flash[:notice].blank?
  end

  def gravatar_url_for(email, size = 24)
    the_hash = Digest::MD5.hexdigest(email).to_s
    "http://www.gravatar.com/avatar/#{the_hash}?s=#{size}&d="
  end

  def admin_menu_item(controller_name)
    button = if request.url.match("/admin/#{t("controllers.#{controller_name}.name")}")
      pill_activate_button_link_to t("controllers.#{controller_name}.name").capitalize, send("admin_#{controller_name}_url")
    else
      pill_button_link_to t("controllers.#{controller_name}.name").capitalize, send("admin_#{controller_name}_url")
    end
    button
  end

  def welcome(user)
    link_to((user.name ? user.name : user.email), nil, :class => "profile")
  end

  def google_analytics
    content = if !website_settings.google_analytics_custom.blank?
                strip_tags(website_settings.google_analytics_custom)
              elsif !website_settings.google_analytics_code.blank?
                <<-EOF
                var _gaq = _gaq || [];
                _gaq.push(['_setAccount', '#{website_settings.google_analytics_code}']);
                _gaq.push(['_trackPageview']);

                (function() {
                var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
                ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
                var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
                })();
                EOF
              end
    content_tag(:script, raw(content), :type => "text/javascript") unless content.blank?
  end
end
