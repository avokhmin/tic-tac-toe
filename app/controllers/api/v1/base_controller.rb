class Api::V1::BaseController < ActionController::Base

  rescue_from Exception                    do |e| api_exception(e, msg: 'Sorry, something went wrong!'); end # Catch all
  rescue_from Apipie::ParamMissing         do |e| api_exception(e, status: 400); end
  rescue_from Apipie::ParamInvalid         do |e| api_exception(e, status: 400); end

  # Defines common parameters used for all API methods.
  def_param_group :common_params do
    formats ['json']
  end

  protected

  def api_exception(exception, options = {})
    message = options[:msg]    || exception.message
    status  = options[:status] || 500

    render json: { success: false, errors: [message] }, status: status
  end

  # Inject request context into serializers.
  def default_serializer_options
    {
      root:         false,
    }
  end

end
