class CreateSections < ActiveRecord::Migration[5.0]
  def change
    create_table :sections do |t|
      t.references :page, foreign_key: true
      t.string :permalink
      t.string :title
      t.text :content
      t.boolean :visible, default: true
      t.boolean :private, default: false
      t.string :image

      t.timestamps
    end
    add_index :sections, :permalink
  end
end
