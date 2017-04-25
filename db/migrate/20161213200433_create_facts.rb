class CreateFacts < ActiveRecord::Migration[5.0]
  def change
    create_table :facts do |t|
      t.string :headline
      t.string :line_one
      t.string :line_two

      t.timestamps
    end
  end
end
