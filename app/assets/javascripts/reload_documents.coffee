jQuery(document).ready ($) ->
  $(document).on "page:update", ->
    $('.fileupload-generic').fileupload()
