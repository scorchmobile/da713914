class CreateVideos < ActiveRecord::Migration[5.0]
  def change
    create_table :videos do |t|
      t.string :hyperlink
      t.string :position
      t.string :link_text

      t.timestamps
    end
  end
end
