class KeepaApiService
  PRODUCTS_URL = "https://api.keepa.com/product?key=%s&domain=6&stats=180&asin=%s"
 
  def initialize(asin)
    @asin = asin
  end

  def book_info
    return nil if response['products'].nil?

    { list_price: list_price * 0.01, 
      sales_rank: sales_rank, 
      publication_date: publication_date
    }
  end

  private

  def lowest_list_price
    list_price_csv = response["products"][0]["csv"][4].last rescue Float::INFINITY
  end

  def publication_date
    response["products"][0]["publicationDate"].to_s.to_date rescue nil
  end
  
  def lowest_price
    response["products"][0]["csv"][1].select.with_index{ |price, index| ((index%2) != 0) && price > -1 }.last || 0
  end

  def list_price
    list_price = response["products"][0]["csv"][4].select.with_index{ |price, index| ((index%2) != 0) && price > -1 }.last rescue 0
  end

  def response
    @response ||= make_request(products_url)
  end

  def book_response
    response["products"][0]
  end

  def sales_rank
    response["products"][0]["csv"][3].last rescue 0
  end

  def products_url
    PRODUCTS_URL % [ENV['KEEPA_API_KEY'], @asin]
  end

  def make_request(url)
    HTTParty.get(url)
  end

end
