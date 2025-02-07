class Practice < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: true
  validates :name, length: { in: 3..20 }

  has_many :postures
end
