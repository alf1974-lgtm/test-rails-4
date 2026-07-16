module Api
  module V1
    class ClassSessionsController < BaseController
      def index
        sessions = ClassSession.includes(:course, :semester, :teacher, :students).all
        render json: sessions.map { |cs| serialize_session(cs) }
      end

      def show
        cs = ClassSession.includes(:course, :semester, :teacher, :students).find_by(id: params[:id])
        return render_not_found("ClassSession") unless cs

        render json: serialize_session(cs)
      end

      private

      def serialize_session(cs)
        {
          id:       cs.id,
          course:   { id: cs.course.id,   name: cs.course.name },
          semester: { id: cs.semester.id, name: cs.semester.name },
          teacher:  { id: cs.teacher.id,  name: cs.teacher.name },
          students: cs.enrollments.map { |e|
            { id: e.student_id, grade: e.grade }
          }
        }
      end
    end
  end
end
