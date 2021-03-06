class User < ApplicationRecord

  mount_uploader :image, ImageUploader
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  #has_many :user_proj_assocs
  #has_many :projects, through: :user_proj_assocs
  has_and_belongs_to_many :projects
  has_many :bugs
end
