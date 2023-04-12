class ChangeUserType < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :user_type, :string
  end
end
