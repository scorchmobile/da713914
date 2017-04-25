class Testimonial < ApplicationRecord

    # Uploader
    require 'mini_magick'
    mount_uploader :image, TestimonialUploader

    # Sort
    default_scope -> { order('position ASC') }

end
