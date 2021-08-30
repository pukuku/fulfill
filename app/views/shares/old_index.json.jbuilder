if @shares
  json.array! @shares do |share|
    json.id share.id
    json.comp share.goal.status
    json.user share.user
    json.name share.user.name
    json.content share.goal.content
    json.category share.category.name
    json.clips share.clips.count
  end
end