class UsersController < ApplicationController
	skip_before_action :authenticate_request, only: %i[create]
	def new
		@user = User.new
	end

	def create
		@user = User.new(permitted_params)
		if @user.save
			@user.update(date_of_joining: Time.new.strftime("%Y-%m-%d"))
			msg = { status: "Ok", message: "Successfully registered!" }
			render :json => msg
		else
			errors = {}
			@user.errors.each do |attribute, message|
				errors[attribute] = []
				attribute_errors = @user.errors[attribute]
				if attribute_errors.kind_of?(Array)
					attribute_errors.each do |error|
						errors[attribute] << error
					end
				else
					errors[attribute] << attribute_errors
				end
			end
			msg = { status: "Nok", message: "Registration was not successful", error: errors }
			render :json => msg
		end
	end

	private

	def permitted_params
		params.permit(:username, :email, :password, :firstname, :lastname, :date_of_birth)
	end
end
