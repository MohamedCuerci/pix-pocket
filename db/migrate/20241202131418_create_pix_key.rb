class CreatePixKey < ActiveRecord::Migration[7.2]
  def change
    create_table :pix_keys do |t|
      t.references :user, null: false, foreign_key: true
      t.string :key, null: false
      t.integer :key_type, null: false
      t.string :registered_at

      t.timestamps
    end
  end
end
