ActiveAdmin.register Arena do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :title, :location, :phone_number, :latitude, :longitude
  #
  # or
  #
  # permit_params do
  #   permitted = [:title, :location, :phone_number, :latitude, :longitude]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
