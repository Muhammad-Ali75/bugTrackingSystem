class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :user_type, presence: true
  validates :name, presence: true

  has_many :projects  
  has_many :user_projects
  has_many :assigned_projects, :through=>  :user_projects, :source=> :project

end
