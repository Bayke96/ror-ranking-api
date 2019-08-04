class CreateUserProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :user_profiles do |t|
      t.references :user, foreign_key: true, null: false
      t.string :firstname, null: false, :limit => 128
      t.string :lastname, null: false, :limit => 128
      t.string :email, null: false, :limit => 128
      t.string :phonenumber, null: false, :limit => 128
      t.string :address, null: false, :limit => 128
    end
  end
end
