require 'rubygems'
begin
	require 'watir'
rescue LoadError
	require 'watir-webdriver'
end
require 'nokogiri'


def browser_instance
	
	@browser_type = :ie

	if Gem.loaded_specs.has_key?('watir-webdriver')
		@browser_type = :ff
		puts "Firefox Browser loaded, using watir-webdriver."
	else
		@browser_type = :ie
		puts "Internet Explorer Browser loaded, using watir."
	end

	# browser_start(Watir Browser Object) : INTERNAL FUNCTION : Select which browser you want to open, and open it.
	if not @browser.respond_to?(:htmls)
		if @browser_type == :ie
			@browser = Watir::IE.new
		else
			@browser = Watir::Browser.new @browser_type
		end
	end
end


def retryable(options = {}, &block)
	opts = { :tries => 1, :on => Exception }.merge(options)

	retry_exceptions, retries = opts[:on], opts[:tries]
	
	exceptLogger = []

	begin
		return yield
	rescue Exception => ex # FIXME # Currently catches everything... need to figure out 'rescue *retry_exceptions
		exceptLogger += [ex.inspect]
		sleep(3)
		retry if (retries -= 1) > 0
	raise StandardError.new("You maxed out on retries!  These error's came back: \n#{exceptLogger.join("\n")}")
	end
end

def watir_must( &block )
	retryable(:tries => 5, :on => [ Watir::Exception::UnknownObjectException, Timeout::Error ] ) do
		yield
	end
end

def google_error?
    watir_must do
	if @browser.h1(:text, "Problem loading Google+").exists?
		fail StandardError.new('Problem loading Google+ in google_error?')
	end
	return false
    end
end
