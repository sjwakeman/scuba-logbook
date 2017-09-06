class User < ActiveRecord::Base
  has_secure_password
  has_many :dives

  def slug
    self.username.downcase.split(/\W/).reject { |w| w.empty? }.join("-")
  end

  def self.find_by_slug(slug)
    # use FIND method to find user from User.all whose slug == slug argument provided
  User.all.find{|user| user.slug == slug}
  end
end
