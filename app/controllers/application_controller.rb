class ApplicationController < ActionController::Base
    before_action :authenticate_user!
    # other configurations...
  
    include Devise::Controllers::Helpers
  end
  