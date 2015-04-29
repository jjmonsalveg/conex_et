# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery(document).ready ($) ->

  $('#escuela_transporte_rif').inputmask "99999999",
    placeholder: ""
    onKeyUp: () ->
      $('#escuela_transporte_form').bootstrapValidator('revalidateField', $(this))

  $('#escuela_transporte_digito_rif').inputmask "99999999",
    placeholder: ""
    onKeyUp: () ->
      $('#escuela_transporte_form').bootstrapValidator('revalidateField', $(this))

  $('#escuela_transporte_telefono').inputmask "(999) 999-9999",
    placeholder: ""
    onKeyUp: () ->
      $('#escuela_transporte_form').bootstrapValidator('revalidateField', $(this))

  $('#escuela_transporte_movil').inputmask "9999999",
    placeholder: ""
    onKeyUp: () ->
      $('#escuela_transporte_form').bootstrapValidator('revalidateField', $(this))

  $('#escuela_transporte_avenida, #escuela_transporte_urbanizacion').inputmask("Regex", {regex: "[a-zA-Z0-9 ._-]{0,50}"})

  $('#escuela_transporte_calle').inputmask("Regex", {regex: "[a-zA-Z0-9 ._-]{0,30}"})

  $('#escuela_transporte_piso').inputmask("Regex", {regex: "[a-zA-Z0-9 ._-]{0,15}"})

  $('#escuela_transporte_form').bootstrapValidator
    feedbackIcons:
      valid: 'fa fa-check ',
      invalid: 'fa fa-times',
      validating: 'fa fa-refresh'
    live: 'enable'
    fields:
      "escuela_transporte[razonSocial]":
        validators:
          notEmpty:
            message: 'Razón Social es Obligatorio'
      "escuela_transporte[nombre_comercial]":
        validators:
          notEmpty:
            message: 'Nombre Comercial es Obligatorio'
      "escuela_transporte[rif]":
        validators:
          notEmpty:
            message: 'RIF es obligatorio'
          regexp:
            regexp: /^([0-9]{1,8})$/
            message: "RIF invalido"
      "escuela_transporte[digito_rif]" :
        validators:
          notEmpty:
            message: 'Último Dígito obligatorio'
          regexp:
            regexp: /^([0-9]{1})$/
            message: "Último Digito RIF invalido"
      "escuela_transporte[telefono]":
        validators:
          notEmpty:
            message: 'Teléfono Local es Obligatorio'
          regexp:
            regexp: /^\x28[0-9]{3}\x29 [0-9]{3}-[0-9]{4}$/
            message: "Teléfono Local incompleto"
      "escuela_transporte[movil]":
        validators:
          notEmpty:
            message: 'Teléfono Móvil es Obligatorio'
          regexp:
            regexp: /^([0-9]{7})$/
            message: "Teléfono Móvil Incompleto"
      "escuela_transporte[email]":
        validators:
          notEmpty:
            message: 'Email es Obligatorio'
          emailAddress:
            message: 'Introduzca un Email Válido'
      "escuela_transporte[url]":
        validators:
          regexp:
            regexp: /^(https?:\/\/(?:www\.|(?!www))[^\s\.]+\.[^\s]{2,}|www\.[^\s]+\.[^\s]{2,})/
            message: 'URL no valida, debe ingresar una página web válida'
      "escuela_transporte[parroquia_id]":
        validators:
          notEmpty:
            message: 'Parroquia es Obligatoria'
      "escuela_transporte[ciudad_id]":
        validators:
          notEmpty:
            message: 'Ciudad es Obligatoria'
      direccion:
        selector: '.direccion'
        validators:
          callback:
            message: "Ingrese al menos una avenida, calle o sector/urbanización"
            callback: (value, validator, $field) ->
              isEmpty = true
              $fields = validator.getFieldElements("direccion")
              i = 0
              while i < $fields.length
                if $fields.eq(i).val() isnt ""
                  isEmpty = false
                  break
                i++
              unless isEmpty
                validator.updateStatus "direccion", validator.STATUS_VALID, "callback"
                $('.bug-dir').each (indice, elemento) ->
                   $(elemento).removeClass('has-error')
                return true
              false
          regexp:
            regexp: /^([\w])/i
            message: 'El campo no puede tener caracteres especiales'
      "escuela_transporte[edificio_cc]":
        validators:
          regexp:
            regexp: /^([\w])/i
            message: "Edificio no puede contener caracteres especiales"
      "escuela_transporte[local]":
        validators:
          regexp:
            regexp: /^([\w])/i
            message: "Local no puede contener caracteres especiales"
      "escuela_transporte[piso]":
        validators:
          regexp:
            regexp: /([\d]{0,2})/
            message: "Piso no puede contener caracteres especiales"


  $('select[data-dynamic-selectable-url][data-dynamic-selectable-target]').dynamicSelectable()

  $('#estado_id_nombre').change ->
    $.ajax
      type: "POST"
      url: "/dynamic_select/ciudad_municipio"
      dataType: "JSON"
      data:
        estado_id: $('#estado_id_nombre').val()
      success: (data) ->
        html_ciudad_select = $('#escuela_transporte_ciudad_id')
        html_municipio_select = $('#municipio_id_nombre')
        html_ciudad_select.empty()
        html_municipio_select.empty()
        $.each data[1], (i, data_each) ->
          html_ciudad_select.append new Option(data_each.label, data_each.id)
        $.each data[0], (i, data_each) ->
          html_municipio_select.append new Option(data_each.label, data_each.id)

  $('.direccion').keyup ->
    $('#escuela_transporte_form').bootstrapValidator('revalidateField', $(this))
    return

#    event.preventDefault()
#    $("#boton_").replaceWith "<input type='file' id='control' />"
