$(document).on("turbolinks:load", function() {

  $(document).on("click", ".modal_display_close", function(){
    $(".modal_display").removeClass("modal_display_active");
    $(".mask_display").removeClass("mask_display_active");
  });

  $(document).on("click", ".mask_display_active", function(){
    $(".modal_display_active").removeClass("modal_display_active");
    $(".mask_display_active").removeClass("mask_display_active");
  });

  $(document).on("click", ".modal_display_btn", function(){
    let error;
    let value = $(".content_form").val();
    if (value == "" || !value.match(/[^\s\t]/)) {
      error = true;
    }
    if (error) {
      $(".modal_display_error").addClass("modal_display_error_active");
      return false;
    }
  });

});



