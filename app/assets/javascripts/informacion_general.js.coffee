jQuery(document).ready ($) ->
  $('#index_preinscripcion_form').bootstrapValidator
    feedbackIcons:
      valid: 'fa fa-check ',
      invalid: 'fa fa-times',
      validating: 'fa fa-refresh'
    live: 'enabled'
    fields:
      "info[escuela]":
        validators:
          notEmpty:
            message: "Debe seleccionar una Escuela de Transporte."
      "info[tipo_escuela]":
        validators:
          notEmpty:
            message: "Debe seleccionar un Tipo de Escuela de Transporte."


