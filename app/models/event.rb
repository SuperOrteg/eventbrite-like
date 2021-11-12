class Event < ApplicationRecord
  has_one_attached :image
	has_many :attendances, dependent: :destroy
	has_many :users, through: :attendances, dependent: :destroy
  belongs_to :administrator, class_name: "User"

  validates :start_date, presence: true, if: :is_datetime_passed?
  validates :duration, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :title, presence: true, length: { in: 5..140 }
  validates :description, presence: true, length: { in: 20..1000 }
  validates :price, presence: true, numericality: { only_integer: true, greater_than: 0, less_than: 1000 }
  validates :location, presence: true

  def is_datetime_passed?
    if start_date < Date.today
      return false
    else
      return true
    end
  end

  def end_date
    return start_date + duration
  end
end
