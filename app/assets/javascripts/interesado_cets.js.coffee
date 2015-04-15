# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery(document).ready ($) ->
  $('#query-buscar-interesado').inputmask("999999999", { "placeholder": "" })

  $('#buscar_cedula_interesado').click ->
    buscar_interesado()

  $("#query-buscar-interesado").pressEnter ->
    buscar_interesado()

  buscar_interesado = ->
    $.ajax
      type: 'POST'
      url: '/interesado_cets/find_interesado_ajax/'
      dataType: 'html'
      data:
        cedula: $('#query-buscar-interesado').val()
      success: (data) =>
        html = $('#interesado_datos')
        html.empty()
        html.append(data)