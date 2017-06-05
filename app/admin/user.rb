ActiveAdmin.register User do
  permit_params :name, :email, :password, :password_confirmation

	form do |f|
    inputs do
      f.semantic_errors
      input :name
      input :email
      input :password
      input :password_confirmation
    end
    actions
	end

  # Filters
  filter :name
  filter :email
  
end
