class CreateUserlanguages < ActiveRecord::Migration[7.0]
  def change
    create_table :userlanguages do |t|
      t.references :user, null: false, foreign_key: true
      t.references :language, null: false, foreign_key: true
      t.boolean :is_active, default: true

      t.timestamps
    end
  end
end
