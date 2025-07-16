class UserMailer < ApplicationMailer
	default from: 'docflow@example.com'

	  def send_credentials(user, password)
	    @user = user
	    @password = password
	    mail(to: @user.email, subject: 'Your Account Credentials')
	  end
end
