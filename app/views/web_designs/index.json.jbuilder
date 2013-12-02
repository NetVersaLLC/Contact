json.count  @web_designs.count

json.web_designs @web_designs do |web_design| 
  json.page_name web_design.page_name
  json.id web_design.id
  json.updated_at_distance_of_time_in_words_to_now  distance_of_time_in_words_to_now( web_design.updated_at ) + " ago"
end 
