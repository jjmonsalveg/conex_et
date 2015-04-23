jQuery(document).ready ($) ->
  $(document).on "page:update", ->
    console.log 'entro a update con:'
    $('.fileupload-generic').fileupload()
#
#    if $(".fileupload-generic").length > 0 && $('.fileupload-generic').attr('load-ajax')
#      console.log 'CUMPLE'
#      cargar_documentos()
#      $('.fileupload-generic').attr('load-ajax',false)
#    return
#
#cargar_archivos = (id) ->
#  $.getJSON $('#'+id).prop('action'), (files) ->
#    fu = $('#'+id).data('blueimpFileupload')
#    console.log 'este es fu'
#    console.log fu
#    console.log 'este es id'
#    console.log $('#'+id)
#    template = undefined
#    template = fu._renderDownload(files).appendTo($('#'+id+' .files'))
#    # Force reflow:
#    fu._reflow = fu._transition and template.length and template[0].offsetWidth
#    template.addClass 'in'
#    $('#loading').remove()
#    return
#  return
#
#
#cargar_documentos = ()->
#  $('.fileupload-generic').each (indice, elemento) ->
#    cargar_archivos(elemento.id)
#    return
#  return