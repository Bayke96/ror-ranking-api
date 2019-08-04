class CreateRanks < ActiveRecord::Migration[5.2]
  def change
    create_table :ranks do |t|
      t.references :department, foreign_key: true, null: false
      t.string :name, null: false, :limit => 128, index: { unique: true }
    end
  end
end
