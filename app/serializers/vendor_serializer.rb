class VendorSerializer
  include JSONAPI::Serializer
  attributes :name, :description, :contact_name, :contact_phone, :credit_accepted

  attribute :states_sold_in do |vendor|
    vendor.markets.select("state").distinct.pluck("state")
  end
end
