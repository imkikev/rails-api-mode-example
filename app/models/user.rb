class User < ApplicationRecord
	has_secure_token
  has_secure_password

   #pagination
  self.per_page = 25

  validates :name, presence: true
  validates :lastname, presence: true
  validates :email, presence: true, uniqueness: true
  validates_format_of  :email, :with => /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  scope :filter_admin, ->(admin) {where('admin = ?', admin == 'true' ? true : false) if admin}

  def self.verify_per_page(size)
  	return per_page unless size
  	return size.to_i > per_page ? per_page : size
  end
  
end
