class CreateClients < ActiveRecord::Migration[7.2]
  def change
    create_table :clients do |t|
      t.string :name
      t.string :email
      t.string :status
      t.integer :assigned_to_id

      t.timestamps
    end
  end
end
