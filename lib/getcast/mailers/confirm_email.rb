
#Hanami::Mailer.configure do
#delivery_method :smtp,
#    address:              "smtp.gmail.com",
#    port:                 587,
#    domain:               "example.com",
#    user_name:            ENV['SMTP_USERNAME'],
#    password:             ENV['SMTP_PASSWORD'],
#    authentication:       "plain",
#    enable_starttls_auto: true
#end.load!

class Mailers::ConfirmEmail
  include Hanami::Mailer

  from    'arturmcuringa@gmail.com'
  to      :recipient
  subject :subject

  private 

  def recipient
   user.email
  end

  def subject
	"Welcome #{user.first_name}!"
  end
end
