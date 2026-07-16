module Api
  module V1
    class StudentsController < BaseController
      before_action :set_student

      # GET /api/v1/students/:id
      # Returns the student's basic info
      def show
        render json: {
          id:    @student.id,
          name:  @student.name,
          email: @student.email,
          role:  @student.role
        }
      end

      # GET /api/v1/students/:id/courses
      # Returns all class sessions (with course + semester info) the student is enrolled in
      def courses
        enrollments = @student.enrollments
                               .includes(class_session: [:course, :semester, :teacher])

        data = enrollments.map do |enrollment|
          cs = enrollment.class_session
          {
            enrollment_id:     enrollment.id,
            grade:             enrollment.grade,
            class_session_id:  cs.id,
            course: {
              id:          cs.course.id,
              name:        cs.course.name,
              description: cs.course.description,
              department:  cs.course.department&.name
            },
            semester: {
              id:         cs.semester.id,
              name:       cs.semester.name,
              start_date: cs.semester.start_date,
              end_date:   cs.semester.end_date
            },
            teacher: {
              id:   cs.teacher.id,
              name: cs.teacher.name
            }
          }
        end

        render json: { student_id: @student.id, courses: data }
      end

      private

      def set_student
        @student = User.find_by(id: params[:id], role: "student")
        render_not_found("Student") unless @student
      end
    end
  end
end
