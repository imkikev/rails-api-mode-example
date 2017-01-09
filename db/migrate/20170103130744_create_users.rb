class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :lastname
      t.string :email
      t.string :password_digest
      t.string :token
      t.boolean :admin

      t.timestamps
    end
  end
end
