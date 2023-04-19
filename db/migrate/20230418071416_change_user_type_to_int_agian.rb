# frozen_string_literal: true

class ChangeUserTypeToIntAgian < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :user_type, :integer
  end
end
