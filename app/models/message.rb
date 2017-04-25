class Message

  # the sauce
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  # Contact Fields
  attr_accessor :first_name, :last_name, :middle_name, :email, :phone, :street1, :street2, :zipcode, :member_type

  # Validation
  validates :first_name, :last_name, :email, :phone, :member_type, presence: true
  validates :email, format: { with: %r{/^[A-Z0-9._%-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i} }, presence: true, allow_blank: false

  # Send them to the model
  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  # Can't be saved
  def persisted?
    false
  end

end
