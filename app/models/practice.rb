class Practice < ApplicationRecord
  validates :name, presence: true, uniqueness: true, length: { in: 3..100 }

  has_many :postures, dependent: :destroy
  belongs_to :user
end
