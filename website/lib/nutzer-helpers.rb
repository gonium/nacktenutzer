
module NutzerHelpers
  #returns the nutzer data hash associated with the requested page
  #prefix
  def get_nutzer_data(page)
    retval = []
    data.nutzer.each do |nutzer|
      if nutzer["page"] == page
        retval = nutzer
        break
      end
    end
    return retval
  end
end
