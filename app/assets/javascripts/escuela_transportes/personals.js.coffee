# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery(document).ready ($) ->
  $("#documento-trabajador-saime").inputmask "9{4,8}",
    placeholder: ""

  $('#search-trabajador-form').bootstrapValidator
    feedbackIcons:
      valid: 'fa fa-check ',
      invalid: 'fa fa-times',
      validating: 'fa fa-refresh'
    live: 'enabled'
    fields:
      "trabajador[cedula]":
        validators:
          notEmpty:
            message: 'Número de Cédula es obligatorio'
          regexp:
            regexp: /^([0-9]{1,8})$/
            message: 'El formato del campo Cedúla es inválido'

  $('#documento-trabajador-saime').keyup ->
    $('#search-trabajador-form').bootstrapValidator('revalidateField', $(this))
    return

$(document).on 'change', '#personal_tipo_personal' , ->
  if $(this).val() == 'instructor'
    $.ajax
      type: "GET"
      url: "/escuela_transportes/instructor_documents"
      dataType: "html"
      success: (data) ->
        $('#document-trabajadores-intructores').html  data
        return
  else
    $('#document-trabajadores-intructores').html  ''
  return