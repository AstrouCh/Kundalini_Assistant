class Posture < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: true
  validates :name, length: { in: 3..20 }

  validates :time, :holding_breath_time, numericality: { less_than_or_equal_to: 50 }
  validates :holding_breath_ending, presence: true

  belongs_to :Practice
  belongs_to :user # can it be then null?
end
