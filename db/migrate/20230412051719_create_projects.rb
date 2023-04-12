class CreateProjects < ActiveRecord::Migration[7.0]
  def change
    create_table :projects do |t|
      t.string :name
      t.text :description
      t.references :user, foreign_key: true, null: false
      t.timestamps
    end
  end
end
