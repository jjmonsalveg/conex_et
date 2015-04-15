jQuery(document).ready ($) ->
  $("#data_1 .input-group.date").datepicker
    keyboardNavigation: true
    forceParse: false
    calendarWeeks: true
    format: 'dd/mm/yyyy'
    language: 'es'
    clearBtn: true
    autoclose: true

  $('.fecha-register').on "keydown", (e) ->
    if(e.which != 13)
     $("#data_1 .input-group.date").datepicker('show')
    return

  $("#registro-usuario-form").bind "submit", ->
    $('#registro-usuario-form').bootstrapValidator 'addField', 'recaptcha_response_field',
      validators: notEmpty: message: 'Campo vacio, introduzca el valor que ve en la imagen'
    $(this).find(":input").removeAttr "disabled"
    return

  $("#documento-saime").inputmask "9{4,8}",
    placeholder: ""

  $("#session_user_usuario_sput_attributes_telefono_local").inputmask "(999) 999-9999",
    placeholder: ""

  $("#session_user_usuario_sput_attributes_movil").inputmask "9999999",
      placeholder: ""


  $("#session_user_usuario_sput_attributes_usuario_attributes_rif").inputmask "9",
    placeholder: ""

  $("#session_user_email").inputmask("Regex", {regex: ".{0,50}"})

  $("#session_user_email_confirmation").inputmask("Regex", {regex: ".{0,50}"})

  $("#session_user_usuario_sput_attributes_correo_alterno").inputmask("Regex", {regex: ".{0,50}"})

  $("#campo-pregunta").inputmask("Regex", {regex: ".{0,30}"})

  $("#session_user_usuario_sput_attributes_respuesta").inputmask("Regex", {regex: ".{0,15}"})

  $('#registro-usuario-form').bootstrapValidator
    feedbackIcons:
      valid: 'fa fa-check ',
      invalid: 'fa fa-times',
      validating: 'fa fa-refresh'
    live: 'enabled'
    fields:
      "session_user[usuario_sput_attributes][representante_legal_attributes][rif]":
        validators:
          notEmpty:
            message: 'RIF es obligatorio'
          regexp:
            regexp: /^([0-9]{1})$/
            message: 'El formato del campo Rif es inválido.Ingresar último dígito'
      "session_user[email]":
        validators:
          notEmpty:
            message: 'Email es Obligatorio'
          emailAddress:
            message: 'Introduzca un Email Válido'
         identical:
           field: 'session_user[email_confirmation]',
           message: 'Correo Electrónico y su confimación deben coincidir'
      "session_user[email_confirmation]":
        validators:
          notEmpty:
            message: 'Confirmar Email es Obligatorio'
          emailAddress:
            message: 'Introduzca un Email Válido'
          identical:
            field: 'session_user[email]',
            message: 'Correo Electrónico y su confimación deben coincidir'
      "session_user[usuario_sput_attributes][correo_alterno]":
        validators:
          emailAddress:
            message: 'Introduzca un Email Válido'
          different:
            field: 'session_user[email]',
            message: 'Correo Alterno debe ser diferente al Correo Electrónico Principal'
      "session_user[usuario_sput_attributes][pregunta_secreta]":
        validators:
          notEmpty:
            message: 'Pregunta secreta es Obligatoria'
          regexp:
            regexp: /^([a-zA-Z ñáéíóúÑÁÉÍÓÚ\d])+$/
            message: 'Formato debe ser Alfanumérico'
      "session_user[usuario_sput_attributes][respuesta]":
        validators:
          notEmpty:
            message: 'Respuesta secreta es Obligatoria'
          regexp:
            regexp: /^([a-zA-Z ñáéíóúÑÁÉÍÓÚ\d])+$/
            message: 'Formato debe ser Alfanumérico'
      "session_user[usuario_sput_attributes][telefono_local]":
        validators:
          regexp:
            regexp: /^\x28[0-9]{3}\x29 [0-9]{3}-[0-9]{4}$/
            message: "Teléfono Local incompleto"
      "session_user[usuario_sput_attributes][movil]":
        validators:
          notEmpty:
            message: 'Teléfono Móvil es Obligatorio'
          regexp:
            regexp: /^([0-9]{7})$/
            message: "Teléfono Móvil Incompleto"
      'session_user[usuario_sput_attributes][representante_legal_attributes][direccion]':
        validators:
          notEmpty:
            message: 'Dirección es Obligatorio'
      'session_user[usuario_sput_attributes][representante_legal_attributes][doc_cedula]':
        validators:
          notEmpty:
            message: 'Documento es Obligatorio'
      'session_user[usuario_sput_attributes][representante_legal_attributes][doc_rif]':
        validators:
          notEmpty:
            message: 'Documento es Obligatorio'

  .on "error.form.bv", (e) ->
    $('#session_user_usuario_sput_attributes_nombre').attr('disabled', true)
    $('#session_user_usuario_sput_attributes_apellido').attr('disabled', true)
    $('#session_user_usuario_sput_attributes_numero_doc').attr('disabled', true)
    $('#select-nacionalidad').attr('disabled', true)

