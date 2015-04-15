json.array!(@parroquias) do |parroquia|
  json.extract! parroquia, :nombre, :id
end