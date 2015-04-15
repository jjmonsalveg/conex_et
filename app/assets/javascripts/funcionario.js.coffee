jQuery(document).ready ($) ->

  $('#funcionario_telefono_casa').inputmask "(999) 999-9999",
    clearIncomplete: true
  $("#funcionario_telefono_celular").inputmask "99/99/9999",
    clearIncomplete: true

  $('#boton-buscar-funcionarios').click ->
    buscar_funcionario()

  $("#query-buscar-funcionarios").pressEnter ->
    buscar_funcionario()

  $("#buscar_cedula_funcionario").click ->
    first_buscar_funcionario()
  $("#text_cedula_funcionario").pressEnter ->
    first_buscar_funcionario()

  $('#new_funcionario').bootstrapValidator
    feedbackIcons:
      valid: 'fa fa-check ',
      invalid: 'fa fa-times',
      validating: 'fa fa-refresh'
    live: 'enabled'
    fields:
      "funcionario[direccion]":
        validators:
          notEmpty:
            message: 'Debe ingresar su dirección'
  $('#form_registro_funcionario').bootstrapValidator
    feedbackIcons:
      valid: 'fa fa-check ',
      invalid: 'fa fa-times',
      validating: 'fa fa-refresh'
    live: 'enabled'
    fields:
      "funcionario[login]":
        validators:
          notEmpty:
            message: 'Debe ingresar un login'
      "funcionario[password]":
        validators:
          notEmpty:
            message: 'Debe ingresar una contraseña'
          regexp:
            regexp: /^(.{8,})$/
            message: 'Contraseña mínima es de 8 carácteres'
      "funcionario[password_confirmation]":
        validators:
          notEmpty:
            message: 'Debe ingresar un valor'
          identical:
            field: 'funcionario[password]'
            message: 'Las contraseñas no coinciden'
      "funcionario[email]":
        validators:
          notEmpty:
            message: 'Debe ingresar el correo eléctronico del funcionario.'

  first_buscar_funcionario = ->
    $.ajax
      type: 'POST'
      url: '/funcionarios/get_info/'
      dataType: 'html'
      data:
        cedula: $('#text_cedula_funcionario').val()
        prefijo: $('#prefijo_prefijo').val()
        dia: $('#fecha_nacimiento_fecha_nacimiento_3i').val()
        mes: $('#fecha_nacimiento_fecha_nacimiento_2i').val()
        ano: $('#fecha_nacimiento_fecha_nacimiento_1i').val()
      success: (data) =>
        html = $('#funcionario_datos')
        html.empty()
        html.append(data)
  buscar_funcionario = ->
    $.ajax
      type: 'POST'
      url: '/funcionarios/buscar_funcionarios/'
      dataType: 'html'
      data:
        query: $('#query-buscar-funcionarios').val()
      success: (data) =>
        html = $('#div-resultados-funcionarios')
        html.empty()
        html.append(data)