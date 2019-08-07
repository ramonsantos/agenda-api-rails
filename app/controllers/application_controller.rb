# frozen_string_literal: true

class ApplicationController < ActionController::API
  before_action :ensure_json_request

  def ensure_json_request
    if request.headers['Accept'] =~ /vnd\.api\+json/
      unless request.get?
        return if request.headers['Content-Type'] =~ /vnd\.api\+json/

        render body: nil, status: :unsupported_media_type
      end
    else
      render body: nil, status: :not_acceptable
    end
  end
end
