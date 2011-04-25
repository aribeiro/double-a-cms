class Setting
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :admin_locale           ,:type => String, :default => "en"
  field :front_locale           ,:type => String, :default => "en"
  field :multi_language         ,:type => Boolean, :default => false
  
  field :website_title          ,:type => String
  field :website_description    ,:type => String
  field :website_keywords       ,:type => String
  field :website_facebook       ,:type => String
  field :website_twitter        ,:type => String
  field :website_orkut          ,:type => String
  field :website_linkedin       ,:type => String

  field :company_country        ,:type => String
  field :company_city           ,:type => String
  field :company_zipcode        ,:type => String
  field :company_neiborhood     ,:type => String
  field :company_street         ,:type => String
  field :company_address_number ,:type => String
  field :company_address_more   ,:type => String

  field :contact_notification_email ,:type => String
  field :contact_website_email      ,:type => String
  field :contact_form_email         ,:type => String

  field :google_analytics_code      ,:type => String
  field :google_analytics_custom    ,:type => String

  validates_presence_of :admin_locale, :front_locale, :multi_language
  validates_presence_of :website_title
end
