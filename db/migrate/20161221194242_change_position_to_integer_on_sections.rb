class ChangePositionToIntegerOnSections < ActiveRecord::Migration[5.0]

    Section.all.each { |s| s.update_attribute :position, 0 }

    def change
        change_column :sections, :position, 'integer USING CAST(position AS integer)', default: 0
    end

end
