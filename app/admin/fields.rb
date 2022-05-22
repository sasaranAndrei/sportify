ActiveAdmin.register Field do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :arena_id, :sport_id, :label, :min_players, :max_players
  #
  # or
  #
  # permit_params do
  #   permitted = [:arena_id, :sport_id, :label, :min_players, :max_players]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
