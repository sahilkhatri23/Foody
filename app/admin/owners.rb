ActiveAdmin.register User, as: 'Restaurant Owner' do
  menu parent: "Accounts"
  filter :name
  filter :username
  filter :email

  permit_params :name, :username, :email, :role, :password

  index do
    selectable_column
    id_column
    column :name
    column :username
    column :email
    column :created_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :username
      f.input :email
      f.input :role
    end
    f.actions
  end

  show do
    attributes_table do
      row :name
      row :email
    end
  end

  controller do
    def scoped_collection
      User.owner
    end

    def update
      user = User.owner.find(params[:id])
      user.update(role: params[:user][:role])
      owner_user_count = User.where(role: "owner").count
      if user.owner? && owner_user_count == 1
        redirect_to admin_restaurant_owner_path(id: params[:id])
      else
        redirect_to admin_owners_path
      end
    end

    def create
      user_params = params.require(:user).permit(:name, :username, :email, :role)
      user = User.create(user_params.merge(password: "#{user_params[:name]}@123"))
      redirect_to admin_restaurant_owner_path(id: user.id)
    end
  end
end
