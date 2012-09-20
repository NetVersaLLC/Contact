class HomePage
  include PageObject

  def self.url
    "#{BASE_URL}businesses/new"
  end
  page_url url

  text_field(:business_name, id: "business_business_name")
  text_field(:local_phone, id: "business_local_phone")
  text_field(:address, id: "business_address")
  textarea(:business_description, id: "business_business_description")
  select(:geographic_areas, id: "business_geographic_areas")

  div(:feedback, class: "alert")
  button(:save_changes, name: "commit")

  def error(element_name)
    element = "#{element_name}_element".downcase.gsub(" ", "_")
    send(element).parent.span.text
  end
end
