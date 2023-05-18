class ErrorMarketVendor
  attr_reader :errors, :status, :code, :id
  def initialize(market_vendor)
    @id = 1
    @errors = format_message(market_vendor.errors.full_messages,
      market_vendor.market_id,
      market_vendor.vendor_id)
    @status = determine_status
    @code = determine_code
  end

  def format_message(message, m_id, v_id)
    if !message.empty?
      [message.first.prepend("Validation failed: ")]
    else
      "No MarketVendor with market_id=#{m_id} AND vendor_id=#{v_id} exists"
    end
  end

  def determine_status
    if @errors.first.include?("Market vendor association")
      "Unprocessable Content"
    else
      "Not Found"
    end
  end

  def determine_code
    if @status == "Unprocessable Content"
      422
    else
      404
    end
  end
end