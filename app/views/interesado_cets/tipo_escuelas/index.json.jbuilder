json.array!(@tipo_escuelas) do |tipo_escuela|
  json.extract! tipo_escuela, :id, :nombre
  json.url tipo_escuela_url(tipo_escuela, format: :json)
end
