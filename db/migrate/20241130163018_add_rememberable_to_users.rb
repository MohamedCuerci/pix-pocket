class AddRememberableToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :remember_create_at, :datetime
  end
end
