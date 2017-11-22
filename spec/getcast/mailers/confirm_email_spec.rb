require 'spec_helper'

describe Mailers::ConfirmEmail do
  before do
    Hanami::Mailer.deliveries.clear
  end
 let(:user) {User.new(first_name:'Artur', email:'arturmcuringa@gmail.com')}

  it 'delivers email' do
    Mailers::ConfirmEmail.deliver(user: user)
    mail = Hanami::Mailer.deliveries.last

    mail.to.must_equal [user.email]
  end
end
