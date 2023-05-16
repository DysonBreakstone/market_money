class MarketFacade
  def self.handle_missing_error(exception)
    {errors: [
      {
        detail: exception.message 
      }
       ]
    }
  end
end