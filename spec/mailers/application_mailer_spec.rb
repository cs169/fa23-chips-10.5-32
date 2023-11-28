# spec/mailers/application_mailer_spec.rb

require 'rails_helper'

RSpec.describe ApplicationMailer, type: :mailer do
  describe 'default settings' do
    it 'has the default from email' do
      expect(ApplicationMailer.default[:from]).to eq('from@example.com')
    end

    it 'has the default mailer layout' do
      expect(ApplicationMailer.default[:layout]).to eq('mailer')
    end
  end

  describe 'email sending' do
    let(:mailer) { ApplicationMailer }
    let(:sample_mail) { mailer.sample_email }

    it 'sends an email' do
      allow(mailer).to receive(:sample_email).and_return(sample_mail)
      expect(sample_mail).to receive(:deliver_now)
      mailer.sample_email.deliver_now
    end
  end
end
