class User < ActiveRecord::Base

  has_many :tweets
  validates :username, :email, :password, presence: true
  validates :email, uniqueness: true
  has_secure_password

  def slug
    self.username.split(" ").map {|i|i.downcase}.join("-")
  end
  
  def self.find_by_slug(slug)
    self.all.find{|instance|instance.slug == slug}
  end

end
