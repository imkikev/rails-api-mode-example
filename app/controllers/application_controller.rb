class ApplicationController < ActionController::API
  before_action :check_header
  
  private
    def check_header
      if ['POST','PUT','PATCH'].include? request.method
        if request.content_type != "application/vnd.api+json"
          head 406 and return
        end
      end
    end

    def validate_type    	 
      if params['data'] && params['data']['type']   
        if params['data']['type'] == controller_name        
          return true          
        end
      end
      head 409 and return
    end
    
    def validate_session
      token = request.headers["X-Api-Key"] 
      head 403 and return unless token
      @current_user = User.find_by token: token
      head 403 and return unless @current_user    
      if 48.hours.ago < @current_user.updated_at
        @current_user.touch 
      else
        @current_user.regenerate_token #need create new session  
      end
    end

    def render_error(resource, status)
      render json: resource, status: status, adapter: :json_api, serializer: ActiveModel::Serializer::ErrorSerializer
    end    

    def active_model_params(options={})
      ActiveModelSerializers::Deserialization.jsonapi_parse(params,options)
    end

    def default_meta
      {
        licence: 'CC-0',
        authors: ['kike']
      }
    end
    
    #Pagination only
    def get_pagination_page
       @page = params[:page] || {"page"=>{"number"=>"1"}}       
    end

    def pagination_meta(object)
      {
        current_page: object.current_page,
        next_page: object.next_page,
        prev_page: object.previous_page,
        total_pages: object.total_pages,
        total_count: object.total_entries
      }
    end
    #end pagination    
end
