$(document).on('turbolinks:load', function() {

  $(document).on('click', ".task_modal_close", function(){
    $('.task_modal').removeClass('task_modal-active');
    $('.task_mask').removeClass('task_mask-active');
  });

  $(document).on('click', ".task_mask-active", function(){
    $('.task_modal-active').removeClass('task_modal-active');
    $('.task_mask-active').removeClass('task_mask-active');
  });
});



