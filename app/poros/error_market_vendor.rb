class ErrorMarketVendor
  attr_reader :errors, :status, :code, :id
  def initialize(market_vendor)
    @id = 1
    @errors = format_message(market_vendor.errors.full_messages)
    @status = determine_status
    @code = determine_code
    # require 'pry'; binding.pry
  end

  def format_message(message)
    [message.first.prepend("Validation failed: ")]
  end

  def determine_status
    if @errors.first.include?("Market vendor association")
      "Unprocessable Content"
    else
      "Not Found"
    end
  end

  def determine_code
    # require 'pry'; binding.pry
    if @status == "Unprocessable Content"
      # require 'pry'; binding.pry
      return 422
    else
      return 404
    end
  end
end