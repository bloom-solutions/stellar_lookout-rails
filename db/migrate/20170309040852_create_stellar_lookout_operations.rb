class CreateStellarLookoutOperations < ActiveRecord::Migration[5.0]
  def change
    create_table :stellar_lookout_operations do |t|
      t.integer :ward_id, index: true
      t.text :body, null: false
      t.string :txn_external_id, index: true, null: false
      t.string :external_id, index: true, null: false
      t.timestamps
    end

    add_foreign_key(:stellar_lookout_operations, :stellar_lookout_wards, {
      column: :ward_id,
    })
    add_foreign_key(:stellar_lookout_operations, :stellar_lookout_txns, {
      column: :txn_external_id,
      primary_key: :external_id,
    })
  end
end
