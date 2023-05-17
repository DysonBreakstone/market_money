class SearchFacade
  def self.handle_missing_error(exception)
    {errors: [
      {
        detail: exception.message 
      }
       ]
    }
  end

  def self.handle_missing_mv_error(exception)
    require 'pry'; binding.pry
    {errors: [
      {
        detail:
      }
       ]
    }
  end
end