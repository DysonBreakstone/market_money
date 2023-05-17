class ErrorMarketVendorSerializer
  include JSONAPI::Serializer
  attributes :errors, :status, :code
end
