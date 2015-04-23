jQuery(document).ready ($) ->
  $(document).on "page:update", ->
    console.log 'entro a update con:'
    $('.fileupload-generic').fileupload()
