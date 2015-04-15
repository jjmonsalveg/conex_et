jQuery(document).ready ($) ->

  $('#aseguradora_id_rif').change ->
    $.ajax
      type: "POST"
      url: "/escuela_transportes/rif"
      dataType: "JSON"
      data:
        id: $('#aseguradora_id_rif').val()
      success: (data) ->
        $('#seguro_vehiculo_rif').val(data[0])

  $("#radio-RCV-individual").click ->
    $("#btn-continuar-seguro").show()
    $("#registro-seguro-form").hide()
    $(".ibox-content.caja-RCV-flota").hide()
    $(".ibox-content.caja-RCV-flota :input").prop("disabled", true)
    return
  $("#radio-RCV-flota").click ->
    $("#btn-continuar-seguro").hide()
    $("#registro-seguro-form").show()
    $(".ibox-content.caja-RCV-flota").show()
    $(".ibox-content.caja-RCV-flota, :input").prop("disabled", false)
    return