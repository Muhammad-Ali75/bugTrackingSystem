# frozen_string_literal: true

class AddNameTypeToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :name, :string
    add_column :users, :user_type, :int
  end
end
