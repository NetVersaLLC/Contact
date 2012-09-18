require "test/unit"
require "rubygems"
require "watir"
require "1_initial_sign_up"


class TestPages < Test::Unit::TestCase

  # Called before every test method runs. Can be used to set up fixture information.
  def setup

    #puts 'Search for the ' + business[ 'business_name' ] + ' business at ' + business[ 'zip' ] + ' zip location'
    @browser = Watir::Browser.start( 'http://local.yahoo.com/browse_state.php' )
    @browser.speed = :slow
    @browser.maximize()

    @data = {} # Refactor to initialize only once
    # Personal account signup details
    @data[ 'first_name' ] = 'MyName' #@data[ 'business_name' ]
    @data[ 'last_name' ] = 'Business'
    @data[ 'gender' ] = 'Male'
    @data[ 'month' ] = 'January'
    @data[ 'day' ] = '1'
    @data[ 'year' ] = '1970'
    @data[ 'country' ] = 'United States'
    @data[ 'language' ] = 'English'
    @data[ 'password' ] = '123123'
    @data[ 'secret_answer_1' ] = 'Lodi'
    @data[ 'secret_answer_2' ] = 'Dodi'
    @data[ 'phone' ] = '(425) 123 2312'

    seed = rand( 1000 ).to_s()
    @data[ 'email' ] = 'yahoo' + seed + '@mybusiness.com'
    @data[ 'business_email' ] = ''
    @data[ 'business_address' ] = '212 main street'
    @data[ 'business_city' ] = 'Bellevue'
    @data[ 'business_state' ] = 'Washington'
    @data[ 'business_zip' ] = '98004'
    @data[ 'business_website' ] = 'http://mybusiness.com'
    @data[ 'business_phone' ] = '(425) 123 2312'
    @data[ 'business_categoty' ] = 'Movie Exhibition'
    @data[ 'fax_number' ] = '(425) 555 5555'
    @data[ 'year_established' ] = '1970'
    @data[ 'payment_methods' ] = [ 'Visa', 'Mastercard' ]
    @data[ 'languages_served' ] = 'English, Ukrainian, French'

  end

  # Called after every test method runs. Can be used to tear down fixture information.
  def teardown

    puts 'Sign out and close the browser'

    if @browser.link( :text => 'Sign Out' ).exists? then
      @browser.link( :text => 'Sign Out' ).click
    end
    @browser.close

  end


  def test_existing_business

    @data[ 'business_name' ] =  'Geisha'
    @data[ 'zip' ] = '65203'
    main( @data )

  end

  def test_not_existing_business

    @data[ 'business_name' ] =  'Hopak'
    @data[ 'zip' ] = '98004'
    main( @data )

  end

  def test_claimed_business

    @data[ 'business_name' ] =  "Glenn's Pools"
    @data[ 'zip' ] = '65202'
    main( @data ) # TODO: try catch for the wait for "Edit business details"

  end

end