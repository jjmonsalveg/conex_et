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
  $('#edit_vehiculo').bootstrapValidator
    feedbackIcons:
      valid: 'fa fa-check'
      invalid: 'fa fa-times'
      validating: 'fa fa-refresh'
    live: 'enabled'
    fields:
      'vehiculo_pre[seguro][num_poliza]':
        validators: notEmpty: message: 'Debe indicar el número de póliza.'
      'vehiculo_pre[seguro][aseguradora_id]':
        validators: notEmpty: message: 'Debe seleccionar una compañia aseguradora.'
      'contrato_arrendamiento[duracion]':
        validators:
          notEmpty:
            message: 'Debe indicar los años de duración del contrato'
      'contrato_arrendamiento[tomo]':
        group: '.group'
        validators: notEmpty: message: 'Debe indicar el numero de Tomo'
      'contrato_arrendamiento[folio]':
        group: '.group'
        validators: notEmpty: message: 'Debe indicar el numero de Folio'
      'contrato_arrendamiento[notaria]': validators: notEmpty: message: 'Debe indicar el numero la Notaria'
      'contrato_arrendamiento[nombre_arrendatario]':
        group: '.group'
        validators: notEmpty: message: 'Debe indicar el Nombre y Apellido/Razón Social'
      'contrato_arrendamiento[rif_arrendatario]':
        group: '.group'
        validators:
          notEmpty: message: 'Debe indicar la C.I/RIF'
#      'contrato_arrendamiento[contrato_arrendamiento_file]':
#        group: '.group'
#        validators:
#          notEmpty: message: 'Contrato de Arrendamiento Notariado es Obligatorio'

  $('#posee_arrendatario').click ->
    if $('#posee_arrendatario').is(':checked')
      $('#contenedor-arrendatario').show()
      $('#contrato_arrendamiento_duracion').prop 'disabled', false
      $('#contrato_arrendamiento_tomo').prop 'disabled', false
      $('#contrato_arrendamiento_notaria').prop 'disabled', false
      $('#contrato_arrendamiento_nombre_arrendatario').prop 'disabled', false
      $('#contrato_arrendamiento_folio').prop 'disabled', false
      $('#contrato_arrendamiento_rif_arrendatario').prop 'disabled', false
      $('#contrato_arrendamiento_file').prop 'disabled', false
      $('#contenedor-arrendatario').find('select').prop 'disabled', false
    else
      $('#contenedor-arrendatario').hide()
      $('#contrato_arrendamiento_duracion').prop 'disabled', true
      $('#contrato_arrendamiento_tomo').prop 'disabled', true
      $('#contrato_arrendamiento_notaria').prop 'disabled', true
      $('#contrato_arrendamiento_nombre_arrendatario').prop 'disabled', true
      $('#contrato_arrendamiento_folio').prop 'disabled', true
      $('#contrato_arrendamiento_rif_arrendatario').prop 'disabled', true
      $('#contrato_arrendamiento_file').prop 'disabled', true
      $('#contenedor-arrendatario').find('select').prop 'disabled', true
    return
