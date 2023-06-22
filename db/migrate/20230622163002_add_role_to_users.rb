class AddRoleToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users do |t|
      t.string :role
    end
  end
end
