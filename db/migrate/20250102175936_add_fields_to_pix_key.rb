class AddFieldsToPixKey < ActiveRecord::Migration[7.2]
  def change
    change_table :pix_keys do |t|
      t.string :merchant_name, null: false
      t.string :merchant_city, null: false
      t.text :description
      t.text :postal_code, null: false
      t.decimal :amount, precision: 10, scale: 2 # Valor opcional para o QR Code
      t.string :transaction_id, limit: 25       # ID opcional da transação
      t.boolean :repeatable, default: false     # QR Code reutilizável?
    end
  end
end

 # ainda preciso rodar