class Practice < ApplicationRecord
  belongs_to :user, optional: true
  validates :name, presence: true, uniqueness: true, length: { in: 3..100 }

  has_many :postures, dependent: :destroy

  # Méthode pour vérifier si la pratique est personnelle (user_id est inutile)
  def personal?
    user.present?
  end
end
