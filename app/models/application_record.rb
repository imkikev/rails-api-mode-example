class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  scope :sort_by_field, ->(params) { order("#{params[:field]} #{params[:order_field]}") if self.new.has_attribute?(params[:field])} 
  
  def self.get_sort_field(sort_param)
      field = nil
      order = nil
      if sort_param
        f = sort_param.split(',').first
        field = f[0] == '-' ? f[1..-1] : f
        order = f[0] == '-' ? 'DESC' : 'ASC'  
      end  
      {field: field, order_field: order}
  end

end
