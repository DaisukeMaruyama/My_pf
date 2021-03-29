class ContactsController < ApplicationController
  
  
  def new
    @contact = Contact.new
  end

  def confirm
    @contact = Contact.new(contact_params)
    if @contact.invalid?
      render :new
    end
  end
  
  # 入力内容に誤りがあった場合
  def back
    @contact = Contact.new(contact_params)
    render :new
  end

  # 実際に送信するアクション

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      ContactMailer.send_mail(@contact).deliver_now
      redirect_to done_path
    else
      render :new
    end
  end

  def done
  end

  private

  def contact_params
    params.require(:contact).permit(
      :email,
      :name,  
      :subject,
      :message
      )
  end


end
