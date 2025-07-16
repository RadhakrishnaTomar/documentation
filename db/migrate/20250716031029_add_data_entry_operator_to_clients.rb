class AddDataEntryOperatorToClients < ActiveRecord::Migration[7.2]
  def change
    add_column :clients, :data_entry_operator_id, :integer
  end
end
