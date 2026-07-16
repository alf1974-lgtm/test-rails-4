module Api
  module V1
    class CoursesController < BaseController
      def index
        render json: Course.includes(:department).all.map { |c|
          c.as_json.merge(department_name: c.department&.name)
        }
      end

      def show
        course = Course.includes(:department).find_by(id: params[:id])
        return render_not_found("Course") unless course

        render json: course.as_json.merge(department_name: course.department&.name)
      end
    end
  end
end
