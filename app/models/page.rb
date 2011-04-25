class Page
  include Mongoid::Document
  include Mongoid::Timestamps
  include ActivityLog
  
  embeds_one :seo

  before_save :update_cached_slug
  validates_presence_of :title, :content
  
  field :title        ,:type => String
  field :content      ,:type => String
  field :cached_slug  ,:type => String
  field :old_slug     ,:type => String

  scope :by_slug, lambda{ |attribute| where(:cached_slug => attribute)}
  
  def to_param
    (slug || id).to_s
  end
  
  def slug
    cached_slug || first_fifteen_words
  end
  
  def first_fifteen_words
    title.to_slug.approximate_ascii.to_s.gsub(/[^A-Za-z0-9]/, " ").split(" ")[0..14].join("-").downcase
  end
  
  def similar_slugs_count
    Page.where(:cached_slug => /^#{first_fifteen_words}(-\d)?$/i).count
  end
  
  def next_similar_slug_number
    last_slug = Page.where(:cached_slug => /^#{first_fifteen_words}(-\d)?$/i).desc(:cached_slug).first
    last_slug.cached_slug.split("-")[-1].to_i + 1
  end
  
  protected
  def update_cached_slug
    new_slug = first_fifteen_words
    new_slug += "-#{next_similar_slug_number}" if similar_slugs_count > 0
    update_old_slug(new_slug)
    self.cached_slug = new_slug
  end

  def update_old_slug(new_slug)
    if self.new_record?
      self.old_slug = new_slug
    elsif self.title_changed?
      self.old_slug = self.cached_slug
    end
  end
end
