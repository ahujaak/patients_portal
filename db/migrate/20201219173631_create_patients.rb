class CreatePatients < ActiveRecord::Migration[6.0]
  def change
    create_table :patients do |t|
      t.string :first_name, null: false
      t.string :last_name
      t.string :phone
      t.string :email, null: false, unique: true

      t.timestamps
    end
    add_index :patients, :email, unique: true
    add_index :patients, :first_name, unique: true
  end
end
