json.payloads @payloads do |payload| 
  json.id            payload.id 
  json.parent_id     payload.parent_id || 'root'
  json.name          payload.name
end 
