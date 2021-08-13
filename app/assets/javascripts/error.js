$(document).on('turbolinks:load', function() {

  $(document).on('click', ".task_modal_btn", function(){
    let error;
    let value = $(".content_form").val();

    if (value == "" || !value.match(/[^\s\t]/)) {
      error = true;
    }

    if (error) {
      $('.task_error').addClass('task_error-active');
      return false;
    }
  });
});
