class ApplicationController < ActionController::Base
	def current_user
		return unless session[:user]
		@current_user ||= User.find_by name: session[:user]
	end

end
