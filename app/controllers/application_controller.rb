class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token
  before_action :forbid, only: :step5

  def forbid
    @forbidden = false
  end
end
