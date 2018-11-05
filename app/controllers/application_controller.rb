class ApplicationController < ActionController::API

    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :render_client_error

    private

    def render_not_found(exception )
        render json: { error: exception.message }, status: :not_found
    end

    def render_client_error(exception )
        render json: { error: exception.message }, status: :bad_request
    end
end
