class AddDeveloperIdToTickets < ActiveRecord::Migration[7.0]
  def change
    add_column :tickets, :developer_id, :integer
  end
end
