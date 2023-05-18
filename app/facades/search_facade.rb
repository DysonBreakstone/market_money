class SearchFacade
  def self.handle_missing_error(exception)
    {errors: [
      {
        detail: exception.message 
      }
       ]
    }
  end

  def self.handle_bad_market_search
    {errors: [
      {
        detail: ["Search parameters must be some combination of City, State, and Name. City by itself, or City and Name without an associated State will not suffice."]
      }
       ]
    }
  end
end