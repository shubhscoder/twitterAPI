class ErrorsController < ApplicationController
	def not_found
		render :json => { status: "Nok", message: "Request resource dose not exist" }
	end

	def exception
		render :json => { status: "Nok", message: "System error. Please try again" }
	end
end
