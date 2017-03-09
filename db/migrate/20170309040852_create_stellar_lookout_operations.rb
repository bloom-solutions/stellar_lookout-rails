class CreateStellarLookoutOperations < ActiveRecord::Migration[5.0]
  def change
    create_table :stellar_lookout_operations do |t|
      t.references :ward, foreign_key: true
      t.text :body, null: false
      t.timestamps
    end
  end
end
