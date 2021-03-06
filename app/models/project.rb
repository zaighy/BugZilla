class Project < ApplicationRecord

  #has_many :user_proj_assocs
  #has_many :users, through: :user_proj_assocs
  has_and_belongs_to_many :users
  has_many :bugs

  validates :title,
            presence: true,
            length: {minimum: 3, maximum: 50}
  validates :description,
            presence: true,
            length: {minimum: 10, maximum: 300}
  resourcify
end