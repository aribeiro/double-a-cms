class Seo
  include Mongoid::Document
  embedded_in :page
  
  field :title        ,:type => String
  field :keywords     ,:type => String
  field :description  ,:type => String
end
