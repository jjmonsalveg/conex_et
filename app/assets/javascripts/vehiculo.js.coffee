jQuery(document).ready ($) ->
  $('#buscar_vehiculo_pre').click ->
    $.ajax
      type: "POST"
      url: "/escuela_transportes/vehiculos/buscar_vehiculo_pre"
      dataType: "html"
      data:
        placa: $('#placa_vehiculo_pre').val()
        s_carroceria: $('#s_carroceria_vehiculo_pre').val()
        ano: $('#ano_vehiculo_pre').val()
      success: (data) ->
        html = $('#div_buscar_vehiculo_pre')
        html.empty()
        html.append(data)

