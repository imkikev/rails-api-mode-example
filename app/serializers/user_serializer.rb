class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :lastname, :email
  link(:self) { api_v1_user_url(object) }  
end