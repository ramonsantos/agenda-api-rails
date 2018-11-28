class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken

  before_action :ensure_json_request

  def ensure_json_request
    unless request.headers['Accept'] =~ /vnd\.api\+json/
      render nothing: true, status: :not_acceptable
    else
      unless request.get?
        return if request.headers['Content-Type'] =~ /vnd\.api\+json/
        render nothing: true, status: :unsupported_media_type
      end
    end
  end
end
