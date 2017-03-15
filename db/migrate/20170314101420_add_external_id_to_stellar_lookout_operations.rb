class AddExternalIdToStellarLookoutOperations < ActiveRecord::Migration[5.0]
  def change
    add_column :stellar_lookout_operations, :external_id, :string, null: false, default: ""
    add_index :stellar_lookout_operations, :external_id
  end
end
