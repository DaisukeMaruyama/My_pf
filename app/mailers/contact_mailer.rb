class ContactMailer < ApplicationMailer
  
  def send_mail(contact)
    @contact = contact
    mail to:   ENV['TOMAIL'], subject: "お客様からのお問い合わせ"
  end
end
