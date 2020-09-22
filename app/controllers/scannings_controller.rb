class ScanningsController < ApplicationController
  
  USER_ID, PASSWORD = "secondbind", "secondbind"

  before_action :authenticate, :only => [ :index ]

  def index
  end

  def scan_book
    outcome = DonationScanner.new(params[:isbn]).result
    render json:  { outcome: outcome}
  end

  def show
  end

  private
   def authenticate
      authenticate_or_request_with_http_basic do |id, password| 
         id == USER_ID && password == PASSWORD
      end
   end

end
