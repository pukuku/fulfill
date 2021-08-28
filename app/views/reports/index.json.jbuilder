json.array! @reports do |event|
  json.id event.id
  json.start event.post_date
  json.end event.post_date
end
