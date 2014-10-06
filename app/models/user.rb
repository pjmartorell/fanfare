class User < ActiveRecord::Base
  ROLES = %w{ user admin }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :product_orders

  ROLES.each do |app_role|
    define_method("is_#{app_role}?") do
      role == app_role
    end
  end
end
