class CreateDocuments < ActiveRecord::Migration[7.2]
  def change
    create_table :documents do |t|
      t.string :title
      t.string :category
      t.integer :client_id

      t.timestamps
    end
  end
end
