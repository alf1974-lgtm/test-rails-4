class User < ApplicationRecord
  ROLES = %w[student teacher].freeze

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :role, inclusion: { in: ROLES }

  # As a teacher
  has_many :taught_sessions, class_name: "ClassSession", foreign_key: :teacher_id, dependent: :nullify

  # As a student
  has_many :enrollments, foreign_key: :student_id, dependent: :destroy
  has_many :class_sessions, through: :enrollments

  def student?
    role == "student"
  end

  def teacher?
    role == "teacher"
  end
end
