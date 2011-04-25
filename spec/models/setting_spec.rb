require 'spec_helper'

describe Setting do
  it {should validate_presence_of(:front_locale)}
  it {should validate_presence_of(:admin_locale)}
  it {should validate_presence_of(:multi_language)}
  it {should validate_presence_of(:website_title)}
end
