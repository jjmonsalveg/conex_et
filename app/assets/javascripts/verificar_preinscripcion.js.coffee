jQuery(document).ready ($) ->


  $('#buscar_numero_solicitud').click ->
    buscar_solicitud()

  $("#query_buscar_solicitud").pressEnter ->
    buscar_solicitud()

  buscar_solicitud = ->
    $.ajax
      type: 'POST'
      url: '/verificar_preinscripcion/buscar_solicitud/'
      dataType: 'html'
      data:
        query: $('#query_buscar_solicitud').val()
      success: (data) =>
        html = $('#div_found_solicitud')
        html.empty()
        html.append(data)

  $('.file').each ->
    animationHover this, 'pulse'
    return

  $('.popUp').popover
    trigger: "hover"
    html: true

    # titulo del popover
    title: ->
      $(this).parent().find(".po-title").html()

    content: ->
      $(this).parent().find(".po-body").html()

    container: "body"
    placement: "bottom"


  $('#showPdfModal').on 'show.bs.modal', (event) ->
    button = $(event.relatedTarget)
    recipient = button.data('document')
    modal = $(this)
    modal.find('.modal-body object').attr('data', recipient)
    return


  $('#help-verificar-preinscripcion').click ->
    $('#ayuda_verificar_preinscripcion').toggle()
    return

  $('#cerrar_ayuda_verificar_preinscripcion').click ->
    $('#ayuda_verificar_preinscripcion').hide()
    return

  $('[id^=collapse-]').first().addClass('in')

  fileUploadErrors =
    maxFileSize: 'File is too big'
    minFileSize: 'File is too small'
    acceptFileTypes: 'Filetype not allowed'
    maxNumberOfFiles: 'Max number of files exceeded'
    uploadedBytes: 'Uploaded bytes exceed file size'
    emptyResult: 'Empty file upload result'

  $('.fileupload-generic').fileupload()


  cargar_archivos = (id) ->
    $.getJSON $('#'+id).prop('action'), (files) ->
        fu = $('.fileupload-generic').data('blueimpFileupload')
        template = undefined
        template = fu._renderDownload(files).appendTo($('#'+id+' .files'))
        # Force reflow:
        fu._reflow = fu._transition and template.length and template[0].offsetWidth
        template.addClass 'in'
        $('#loading').remove()
        return
    return


  cargar_documentos = ()->
    $('.fileupload-generic').each (indice, elemento) ->
      cargar_archivos(elemento.id)
      return
    return

  cargar_documentos()
