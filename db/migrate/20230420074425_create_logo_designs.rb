class CreateLogoDesigns < ActiveRecord::Migration[7.0]
  def change
    create_table :logo_designs do |t|
      t.references :user, null: false, foreign_key: true
      t.string :filename
      t.bigint :filesize
      t.boolean :is_active, default: true
      t.bigint :created_by
      t.bigint :updated_by



      t.timestamps
    end
  end
end
