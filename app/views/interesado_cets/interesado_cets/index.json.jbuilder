json.array!(@interesado_cets) do |interesado_cet|
  json.extract! interesado_cet, :id, :nombre, :apellido, :nacionalidad, :numero_doc, :telefono, :email
  json.url interesado_cet_url(interesado_cet, format: :json)
end
