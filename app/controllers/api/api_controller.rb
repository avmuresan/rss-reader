class Api::ApiController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  before_action :force_json_format

  protected

  def not_found
    head :not_found
  end

  def force_json_format
    request.format = :json
  end
end
