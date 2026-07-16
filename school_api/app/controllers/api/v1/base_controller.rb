module Api
  module V1
    class BaseController < ApplicationController
      private

      def render_not_found(resource = "Record")
        render json: { error: "#{resource} not found" }, status: :not_found
      end
    end
  end
end
