json.array! @reports do |event|
  json.id event.id
  json.start event.created_at
  json.end event.created_at
end