ActiveAdmin.register User do
  permit_params :name, :email, :password, :password_confirmation

  before_create { |user| user.skip_confirmation! }
  after_create { |user| 
    user.send_reset_password_instructions 
    WelcomeMailer.account_created_email(user.name, user.email).deliver_later
  }

  # customized index table
  index do
    selectable_column
    id_column
    column :name
    column :email
    column :sign_in_count
    column :created_at
    actions
  end

  # customized new/edit form
	form do |f|
    inputs do
      f.semantic_errors
      input :name
      input :email
      if f.object.new_record?
        input :password, label: "Password (dummy)"
        input :password_confirmation
      end
    end
    actions
	end

  # Filters
  filter :name
  filter :email
  
end
