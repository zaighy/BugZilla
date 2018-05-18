class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  enum user_type: %i[ Developer Manager QA ]

  has_many :user_proj_assocs
  has_many :projects, through: :user_proj_assocs
end
