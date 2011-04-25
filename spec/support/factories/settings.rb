# Read about factories at http://github.com/thoughtbot/factory_girl

Factory.define :setting do |f|
  f.admin_locale "en"
  f.front_locale "en"
  f.multi_language false
  f.website_title "AA CMS Site"
end
