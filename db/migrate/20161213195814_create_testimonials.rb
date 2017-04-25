class CreateTestimonials < ActiveRecord::Migration[5.0]
  def change
    create_table :testimonials do |t|
      t.string :image
      t.string :author
      t.string :content
      t.string :css_bottom
      t.string :css_left
      t.string :testimonial_type

      t.timestamps
    end
  end
end
