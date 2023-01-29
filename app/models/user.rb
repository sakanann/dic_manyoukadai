class User < ApplicationRecord
  before_destroy :admin_exist_check
  before_update :admin_update_exist

  has_many :tasks
  has_secure_password

  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 },
             format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  before_validation { email.downcase! }

  validates :password, length: { minimum: 6 }


  def admin_exist_check
    if User.where(admin: true).count <= 1 && self.admin == true
      throw(:abort)
    end
  end

  def admin_update_exist
    if User.where(admin: true).count == 1 && self.admin == false
      throw(:abort)
    end
  end




end
