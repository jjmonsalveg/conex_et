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
    #$(".continuar-seguro-pregunta").show()
    $("#registro-seguro-form").hide()
    $(".ibox-content.caja-RCV-flota").hide()
    $("#aseguradora_id_rif").prop("disabled", true)
    $('#solicitud_aumento_cupo_seguro_vehiculo_num_poliza').prop("disabled", true)
    $('#fecha_vencimiento_div').find('select').prop("disabled", true)
    $('#solicitud_aumento_cupo_seguro_vehiculo_num_poliza')
    $('#poliza_digital_file_field').prop("disabled", true)
    $('#poliza_accidentes_personales_file_field').prop("disabled", true)
    $('#solicitud_aumento_cupo_seguro_vehiculo_documentos_attributes_0_documentos_requisitos_por_vista_id').prop("disabled", true)
    $('#solicitud_aumento_cupo_seguro_vehiculo_documentos_attributes_1_documentos_requisitos_por_vista_id').prop("disabled", true)
    $('#colsm9_seguro_rcv').hide()
    $('#colsm5_seguro_rcv').show()
    #$("#submit_form_seguro_rcv").hide()
    return

  $("#radio-RCV-flota").click ->
    $("#btn-continuar-seguro").hide()
    #$(".continuar-seguro-pregunta").hide()
    $("#registro-seguro-form").show()
    $(".ibox-content.caja-RCV-flota").show()
    $(".ibox-content.caja-RCV-flota, :input").prop("disabled", false)
    $('#colsm9_seguro_rcv').show()
    $('#colsm5_seguro_rcv').hide()
    #$("#submit_form_seguro_rcv").show()
    return