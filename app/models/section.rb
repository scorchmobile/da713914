class Section < ApplicationRecord

    # Uploader
    require 'mini_magick'
    mount_uploader :image, SectionUploader

    # Relationships
    belongs_to :page

    # Sort
    default_scope -> { order('position ASC') }

end
