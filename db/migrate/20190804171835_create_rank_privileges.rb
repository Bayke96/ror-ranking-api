class CreateRankPrivileges < ActiveRecord::Migration[5.2]
  def change
    create_table :rank_privileges do |t|
      t.references :department, foreign_key: true, null: false
      t.references :rank, foreign_key: true, null: false
      t.boolean :create, null: false, default: false
      t.boolean :read, null: false, default: false
      t.boolean :update, null: false, default: false
      t.boolean :delete, null: false, default: false
    end
  end
end
