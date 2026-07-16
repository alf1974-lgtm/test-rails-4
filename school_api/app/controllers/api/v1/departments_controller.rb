module Api
  module V1
    class DepartmentsController < BaseController
      def index
        render json: Department.all
      end

      def show
        department = Department.includes(:courses).find_by(id: params[:id])
        return render_not_found("Department") unless department

        render json: department.as_json(include: :courses)
      end
    end
  end
end
