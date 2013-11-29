json.id   @web_design.id
json.body @web_design.body 

json.web_images @web_design.web_images do |web_image| 
  json.id  web_image.id
  json.src web_image.data.url(:gallery) 
end 
