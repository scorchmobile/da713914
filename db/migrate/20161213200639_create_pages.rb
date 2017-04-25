class CreatePages < ActiveRecord::Migration[5.0]
  def change
    create_table :pages do |t|
      t.string :title
      t.boolean :visible, default: true
      t.boolean :private, default: false
      t.string :permalink

      t.timestamps
    end
    add_index :pages, :permalink
  end
end
