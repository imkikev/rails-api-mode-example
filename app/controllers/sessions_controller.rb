class SessionsController < ApplicationController

  before_action :validate_type, only: [:create]

  def create
    data = active_model_params          
    user = User.find_by(email: data[:email])
    head 406 and return unless user
    if user.authenticate(data[:password])
      user.regenerate_token      
      render json: user, status: :created, meta: default_meta,
             serializer: ActiveModel::Serializer::SessionSerializer and return    
    end
    head 403
  end

  def destroy    
    user = User.find_by(token: params[:id])
    head 404 and return unless user
    user.regenerate_token        
    head 204
  end
 
end
