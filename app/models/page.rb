class Page
  include Mongoid::Document
  include Mongoid::Timestamps
  field :title, :type => String
  field :content, :type => String

  validates_presence_of :title, :content
end
