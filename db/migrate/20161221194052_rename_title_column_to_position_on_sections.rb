class RenameTitleColumnToPositionOnSections < ActiveRecord::Migration[5.0]
  def change
    rename_column :sections, :title, :position
  end
end
