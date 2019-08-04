class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.references :department, foreign_key: true, null: false
      t.references :rank, foreign_key: true, null: false
      t.string :name, null: false, :limit => 128, index: { unique: true }
      t.string :password, null: false, :limit => 128
    end
  end
end
