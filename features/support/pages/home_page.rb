class HomePage
  include PageObject

  def self.url
    "#{BASE_URL}businesses/new"
  end
  page_url url

  div(:feedback, class: "alert")
end
