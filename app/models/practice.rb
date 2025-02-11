class Practice < ApplicationRecord
  validates :name, presence: true, uniqueness: true, length: { in: 3..20 }

  has_many :postures, dependent: :destroy
  belongs_to :user
end
