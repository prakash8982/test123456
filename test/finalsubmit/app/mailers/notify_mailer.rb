class NotifyMailer < ApplicationMailer
	default from: 'no-reply@nitk.edu.in'

	def recive_email
		@user = params[:user]
		mail(to: @user.email, subject: "you recived an application ")
	end
end
