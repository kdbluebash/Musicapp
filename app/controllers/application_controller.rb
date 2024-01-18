class ApplicationController < ActionController::Base
    before_action :authenticate_user!  
    include Devise::Controllers::Helpers
  end
  