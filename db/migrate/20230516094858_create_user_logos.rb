class CreateUserLogos < ActiveRecord::Migration[7.0]
  def change
    create_table :user_logos do |t|
      t.references :user, null: false, foreign_key: true
      t.string :filename
      t.bigint :filesize
      t.boolean :is_active, default: true
      t.references :logo_design, null: false, foreign_key: true

      t.timestamps
    end
  end
end
