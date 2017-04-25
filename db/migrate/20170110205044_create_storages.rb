class CreateStorages < ActiveRecord::Migration[5.0]
  def change
    create_table :storages do |t|
      t.string :first_adv

      t.timestamps
    end
  end
end
