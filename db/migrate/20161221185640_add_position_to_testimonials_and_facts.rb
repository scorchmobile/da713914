class AddPositionToTestimonialsAndFacts < ActiveRecord::Migration[5.0]
  def change
    add_column :facts, :position, :integer, default: 0
    add_column :testimonials, :position, :integer, default: 0
  end
end
