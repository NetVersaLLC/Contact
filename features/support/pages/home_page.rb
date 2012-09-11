class HomePage
  include PageObject

  def self.url
    "#{BASE_URL}businesses/new"
  end
  page_url url

  text_field(:business_name, id: "business_business_name")
  div(:feedback, class: "alert")
  button(:save_changes, name: "commit")

  def business_name_error_element
    business_name_element.parent
  end
end
