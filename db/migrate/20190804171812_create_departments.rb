class CreateDepartments < ActiveRecord::Migration[5.2]
  def change
    create_table :departments do |t|
      t.string :name, null: false, :limit => 128, index: { unique: true }
      t.integer :employees, null: false, default: 0
    end
  end
end
