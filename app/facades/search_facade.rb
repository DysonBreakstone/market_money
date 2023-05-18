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
        detail: ["City by itself, or City and Name without an associated State are not valid search parameters."]
      }
       ]
    }
  end

  def self.handle_empty_results
    {data: []}
  end
end