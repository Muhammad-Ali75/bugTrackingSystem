# frozen_string_literal: true

class AddProjectIdToTickets < ActiveRecord::Migration[7.0]
  def change
    add_column :tickets, :project_id, :integer
    add_index :tickets, :project_id
  end
end
