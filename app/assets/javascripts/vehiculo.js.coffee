jQuery(document).ready ($) ->

  $('#buscar_vehiculo_pre').click ->
    $('#div_buscar_vehiculo_pre').empty()
    $('#loading_buscar_vehiculo').show()
    $.ajax
      type: "POST"
      url: "/escuela_transportes/vehiculos/buscar_vehiculo_pre"
      dataType: "html"
      data:
        placa: $('#placa_vehiculo_pre').val()
        s_carroceria: $('#s_carroceria_vehiculo_pre').val()
        ano: $('#ano_vehiculo_pre').val()
        id: $('#escuela_transporte_hidden').val()
      success: (data) ->
        html = $('#div_buscar_vehiculo_pre')
        html.empty()
        html.append(data)
      complete: ->
        $('#loading_buscar_vehiculo').hide()

