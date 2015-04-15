json.array!(@rols) do |rol|
  json.extract! rol, :id, :nombre
  json.url rol_url(rol, format: :json)
end
