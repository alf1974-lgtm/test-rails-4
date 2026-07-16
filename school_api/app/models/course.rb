class Course < ApplicationRecord
  belongs_to :department

  validates :name, presence: true

  has_many :class_sessions, dependent: :destroy
end
