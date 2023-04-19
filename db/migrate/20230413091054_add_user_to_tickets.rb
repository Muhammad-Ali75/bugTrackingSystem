# frozen_string_literal: true

class AddUserToTickets < ActiveRecord::Migration[7.0]
  def change
    add_reference :tickets, :user
  end
end
