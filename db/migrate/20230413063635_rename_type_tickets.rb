class RenameTypeTickets < ActiveRecord::Migration[7.0]
  def change
    remove_column :tickets, :type
    add_column :tickets,:category,:integer
  end
end
