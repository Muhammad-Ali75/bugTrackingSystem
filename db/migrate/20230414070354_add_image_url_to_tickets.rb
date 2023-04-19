# frozen_string_literal: true

class AddImageUrlToTickets < ActiveRecord::Migration[7.0]
  def change
    add_column :tickets, :image_url, :string
  end
end
