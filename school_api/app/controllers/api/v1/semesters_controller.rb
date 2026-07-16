module Api
  module V1
    class SemestersController < BaseController
      def index
        render json: Semester.all
      end

      def show
        semester = Semester.find_by(id: params[:id])
        return render_not_found("Semester") unless semester

        render json: semester
      end
    end
  end
end
