ActiveAdmin.register User, as: 'customer' do
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
      User.customer
    end

    def update
      customer = User.customer.find(params[:id]).update(role: params[:user][:role])
      if customer
        redirect_to admin_customers_path
      else
        redirect_to admin_customers_path
      end
    end

    def create
      user_params = params.require(:user).permit(:name, :username, :email, :role)
      User.create(user_params.merge(password: "#{user_params[:name]}@123"))
      redirect_to admin_customer_path(id: User.last.id)
    end
  end
end