class Fact < ApplicationRecord

    # Sort
    default_scope -> { order('position ASC') }

end
