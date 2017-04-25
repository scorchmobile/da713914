class AddContentToTempData < ActiveRecord::Migration[5.0]
  def change
    add_column :temp_data, :content, :text
  end
end
