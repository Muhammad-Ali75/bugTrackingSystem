# frozen_string_literal: true

class CreateTickets < ActiveRecord::Migration[7.0]
  def change
    create_table :tickets do |t|
      t.string :title
      t.integer :type
      t.integer :status
      t.date :deadline
      t.text :description
      t.timestamps
    end
  end
end
