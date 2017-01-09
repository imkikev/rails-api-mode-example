class Api::V1::UsersController < ApplicationController
	before_action :get_pagination_page, only: [:index]
	before_action :validate_session, only: [:create, :update, :destroy, :show]
  before_action :set_user, only: [:show, :update, :destroy]
  before_action :validate_type, only: [:create, :update]


	def index
		sort_params = User.get_sort_field(params ? params[:sort] : nil)
		admin = params ? params[:admin] : nil
		users = User.filter_admin(admin).sort_by_field(sort_params).paginate :page => @page[:number], :per_page => User.verify_per_page(@page[:size])
		render json: users,  meta: pagination_meta(users) 
	end


	def show		
  	render json: @user
	end

	def create
    user = User.new(active_model_params)
    if user.save
      render json: user, status: :created, meta: default_meta
    else
      render_error(user, :unprocessable_entity)
    end
  end

	def update
    if @user.update_attributes(active_model_params(only: [:name, :lastname]))
      render json: @user, status: :ok
    else
      render_error(@user, :unprocessable_entity)
    end
  end

  def destroy
  	if @current_user.admin
    	@user.destroy
    	head 204
    else
    	head 403
    end	
  end

	private
	  def set_user
	    begin
	      @user = User.find params[:id]
	    rescue ActiveRecord::RecordNotFound
	      user = User.new
	      user.errors.add(:id, "No way dude")
	      render_error(user, 404) and return
	    end
	  end
end
