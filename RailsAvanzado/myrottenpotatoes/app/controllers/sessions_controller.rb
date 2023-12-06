class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def new
    render :new
  end

  def create
    auth = auth_hash
    user = Moviegoer.find_by(provider: auth['provider'], uid: auth['uid'])
    
    if user.nil?
      # El usuario no existe, crea un nuevo usuario si es necesario
      user = Moviegoer.create(provider: auth['provider'], uid: auth['uid'], name: auth['info']['name'])
    end

    session[:user_id] = user.id
    redirect_to movies_path
  end

  def destroy
    session.delete(:user_id)
    flash[:notice] = 'Logged out successfully.'
    redirect_to movies_path
  end

  protected 
  def auth_hash
    request.env['omniauth.auth']
  end	

end