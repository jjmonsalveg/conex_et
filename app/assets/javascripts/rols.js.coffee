jQuery(document).ready ($) ->
  $('#new_rol').bootstrapValidator
    feedbackIcons:
      valid: 'fa fa-check ',
      invalid: 'fa fa-times',
      validating: 'fa fa-refresh'
    live: 'enabled'
    fields:
      "rol[nombre]":
        validators:
          notEmpty:
            message: 'Debe ingresar un nombre para el Rol'