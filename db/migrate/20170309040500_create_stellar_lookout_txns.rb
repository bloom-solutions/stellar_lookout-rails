class CreateStellarLookoutTxns < ActiveRecord::Migration[5.0]
  def change
    create_table :stellar_lookout_txns do |t|
      t.string :external_id, null: false
      t.text :body
      t.timestamps
    end

    add_index :stellar_lookout_txns, :external_id, unique: true
  end
end
