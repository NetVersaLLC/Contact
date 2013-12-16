json.payloads @payloads do |payload| 
  json.id            payload.id 
  if payload.parent_id.nil? || payload.parent_id == 1 
    json.parent_id     'root' 
  else 
    json.parent_id     payload.parent_id
  end 
  if payload.site
    json.name          "#{payload.site.name}/#{payload.name}"
  else 
    json.name          payload.name
  end
end 
