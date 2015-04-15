json.array!(@ciudades) do |ciudad|
  json.extract! ciudad, :nombre, :id
end