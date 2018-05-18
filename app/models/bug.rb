class Bug < ApplicationRecord
  has_many :bug_assocs
  has_many :projects, through: :bug_assocs
  has_many :users, through: :bug_assocs
end
