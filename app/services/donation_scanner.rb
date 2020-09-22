class DonationScanner
  NOT_FOUND = 'Not Found'
  INSPECT   = 'Inspect'
  KEEP      = 'Keep'
  DONATE    = 'Donate'
  REFILLING_TOKENS = 'Refilling Tokens'

  def initialize asin = nil
    @asin = formatted_asin asin 
  end
  
  def result
    begin
      return REFILLING_TOKENS if response == 'Not Enough Tokens'
      return NOT_FOUND if response.nil?
      
      outcome = if (formula_1 | formula_2 | formula_3 | formula_4)
        KEEP
      else
        DONATE
      end
    rescue => e
      outcome = INSPECT
    end

    return outcome
    
  end

  private 

  def response
    @response ||= KeepaApiService.new(@asin).book_info
  end

  def formula_1
    sales_rank > 0 && 
    sales_rank < 1000000 &&
    list_price > 50 &&
    publication_date.year > 2010
  end

  def formula_2
    sales_rank > 1200000 && 
    sales_rank < 2000000 &&
    list_price > 50 &&
    publication_date.year > 2017
  end

  def formula_3
    sales_rank > 0 && 
    sales_rank < 750000 &&
    list_price >= 30 &&
    list_price <= 50 &&
    publication_date.year > 2000
  end

  def formula_4
    sales_rank > 0 && 
    sales_rank < 750000 &&
    list_price > 50 &&
    publication_date.year < 2000
  end

  def sales_rank 
    @response[:sales_rank]
  end

  def list_price
    @response[:list_price]
  end

  def publication_date
    @response[:publication_date]
  end

  def formatted_asin asin
    return asin[-10..-1]
  end
end