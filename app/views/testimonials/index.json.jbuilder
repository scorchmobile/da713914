json.array!(@testimonials) do |testimonial|
  json.extract! testimonial, :id, :image, :author, :content, :css_bottom, :css_left, :testimonial_type
  json.url testimonial_url(testimonial, format: :json)
end
