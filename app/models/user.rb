class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validate :check_username

  def check_username
    if self.username.match(/[^a-zA-Z0-9-]+/)
      errors.add(:name, "Names can only contain letters, numbers and hyphens")
    end

    if self.username.length < 3 or self.username.length > 20
      errors.add(:name, "Names can be between 3 and 20 characters long.")
    end
  end
end
