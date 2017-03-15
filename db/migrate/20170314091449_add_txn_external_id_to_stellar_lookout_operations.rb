class AddTxnExternalIdToStellarLookoutOperations < ActiveRecord::Migration[5.0]
  def change
    add_column :stellar_lookout_operations, :txn_external_id, :string
    add_index :stellar_lookout_operations, :txn_external_id
  end
end
