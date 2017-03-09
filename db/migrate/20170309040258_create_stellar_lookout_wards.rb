class CreateStellarLookoutWards < ActiveRecord::Migration[5.0]
  def change
    create_table :stellar_lookout_wards do |t|
      t.string :address, null: false, index: true, unique: true
      t.string :secret, null: false
      t.timestamps
    end
  end
end
