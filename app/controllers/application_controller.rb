class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
	def not_found
    render json: { error: 'not_found' }
  end

  def authorize_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    begin
      @decoded = JsonWebToken.decode(header)
      @current_user = User.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end

  def authenticate_user!
    byebug
    token = request.headers[:token] || params[:token]
    begin
      @token = JsonWebToken.decode(token)
    rescue *ERROR_CLASSES => exception
      handle_exception exception
    end
  end

  def handle_exception(exception)
    case exception
    when JWT::ExpiredSignature
      return render json: { errors: [token: 'Token has Expired'] },
        status: :unauthorized
    when JWT::DecodeError
      return render json: { errors: [token: 'Invalid token'] },
        status: :bad_request
    end
  end

  def set_current_user
    curr_user = User.find(@token["user_id"])
  end
end

