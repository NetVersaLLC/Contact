require "nokogiri"

class PayloadFramework
  attr_reader :data
  def initialize(name,data,job)
    @data = {}
    @name = name
    @job = job
    data.each do |key, value|
      @data[:"#{key}"] = value
    end
    elements
    run
  end

  def context(name=false)
    if name
      old_context = @context
      @context = name
      yield
      @context = old_context
    else
      @context or :main
    end
  end

  def wait_until
    Watir::Wait.until {yield}
  end

  def save(*args)
    credentials = {}
    args.each do |arg|
      if data.include? arg
        credentials[arg] = data[arg]
      elsif arg.respond_to? :keys
        credentials.merge! arg
      else
        raise TypeError, "expected data member or hash; got #{arg.class}"
      end
    end
    @job.save_account(@name,credentials)
  end

  def chain(payload)
    name = @name
    @job.instance_eval do
      payload = [name,payload].join("/")
      self.start(payload) if @chained
    end
  end

  def enter(element,content=data[element])
    browser.text_field(:xpath => xpath_for(element)).set content
  end

  def select(element,content=data[element])
    browser.select(:xpath => xpath_for(element)).select content
  end

  def click(element)
    browser.element(:xpath => xpath_for(element)).click
  end

  def check(element)
    browser.checkbox(:xpath => xpath_for(element)).set
  end

  def uncheck(element)
    browser.checkbox(:xpath => xpath_for(element)).clear
  end

  def submit
    browser.element(:xpath => xpath_for(:submit)).click
  end

  def wait_until_present(element)
    browser.element(:xpath => xpath_for(element)).wait_until_present
  end

  def wait_while_present(element)
    browser.element(:xpath => xpath_for(element)).wait_while_present
  end

  def _solve_captcha
    captcha_image = xpath_for(:captcha_image)
    if !!@manual_captcha
      print "\nPlease enter the text in the CAPTCHA image: "
      captcha_text = gets.chomp
    else
      image = "#{ENV['USERPROFILE']}\\citation\\showinusa_captcha.png"
      obj = browser.img(:xpath => captcha_image)
      puts "CAPTCHA source: #{obj.src}"
      puts "CAPTCHA width: #{obj.width}"
      obj.save image
      captcha_text = CAPTCHA.solve image, :manual
    end
    captcha_text
  end

  def solve
    captcha_field = xpath_for(:captcha_field)
    until captcha_solved ||= false
      browser.text_field(:xpath => captcha_field).set _solve_captcha
      if yield
        captcha_solved= true
      else
        attempts ||= 0
        attempts += 1
        raise "Captcha could not be solved" if attempts > 5
        if elements[context].include? :captcha_reload
          captcha_reload = xpath_for(:captcha_reload)
          browser.element(:xpath => captcha_reload).click
        end
      end
    end
  end

  def context_member(name,value=nil)
    if elements[context][:members].nil?
      raise "Context #{context} has no members!"
    elsif elements[context][:members][name.to_sym].nil?
      raise "Context member #{name} is not defined on #{context}!"
    end
    @elements[context][:members][name.to_sym] = value unless value.nil?
    @elements[context][:members][name.to_sym]
  end

  def build_selector(element)
    context_elements = elements[context]
    parent = elements[context_elements[:parent]][:wrapper] rescue nil
    wrapper = context_elements[:wrapper]
    selector = context_elements[element]
    if selector.nil?
      member, selector = element.to_s.split(":").map{|s|s.to_sym}
      if context_elements[:members].keys.include? member
        template = context_elements[selector]
        selector = template.gsub(/!!!/,context_member(member))
      else
        raise "Element not defined: #{element}"
      end
    end
    if selector[0].chr == "/"
      selector = selector [1..-1]
    else
      selector = wrapper.gsub(/!!!/,selector) unless wrapper.nil?
      selector = parent.gsub(/!!!/,selector) unless parent.nil?
    end
    selector
  end

  def xpath_for(element)
    Nokogiri::CSS.xpath_for(build_selector(element)).first
  end

  def browser
    @browser ||= Watir::Browser.new :firefox
  end

  def self._to_s
    File.read File.expand_path(__FILE__)
  end
end