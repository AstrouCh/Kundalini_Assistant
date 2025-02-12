
class Posture < ApplicationRecord
  validates :name, presence: true, uniqueness: true, length: { in: 3..20 }

  validates :time, numericality: { less_than_or_equal_to: 300 }
  validates :holding_breath_time, numericality: { less_than_or_equal_to: 300 }, allow_nil: true

  belongs_to :practice
  belongs_to :user, optional: true
end
