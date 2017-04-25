class CreateTempData < ActiveRecord::Migration[5.0]
  def change
    create_table :temp_data do |t|
      t.string :first_name
      t.string :last_name
      t.string :middle_name
      t.string :email
      t.string :phone
      t.string :street1
      t.string :street2
      t.string :zipcode
      t.string :member_type

      t.timestamps
    end
  end
end
