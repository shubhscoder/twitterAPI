class ErrorsController < ApplicationController
	def not_found
		render :json => { status: "Nok", message: "Requested resource does not exist" }
	end

	def exception
		render :json => { status: "Nok", message: "Some error has occurred please try again later" }
	end
end
