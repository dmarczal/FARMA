class ContactsController < ApplicationController

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      flash.now[:notice] = "Contato enviada com sucesso."
      @contact = Contact.new
    else
      flash.now[:error] = "Existem dados incorretos."
    end
  end


  private
    def contact_params
      params.require(:contact).permit(:name, :email, :message)
    end
end
