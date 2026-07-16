class Enrollment < ApplicationRecord
  belongs_to :class_session
  belongs_to :student, class_name: "User", foreign_key: :student_id

  validates :student_id, uniqueness: { scope: :class_session_id, message: "already enrolled in this class session" }
end
