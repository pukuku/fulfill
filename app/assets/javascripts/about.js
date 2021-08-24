$(document).on('turbolinks:load', function () {

  $(document).on('click', "#slider_btn_1", function(){
    $('#slider_inner').removeClass();
    $('#slider_inner').addClass("slider_sel_1");
  });

  $(document).on('click', "#slider_btn_2", function(){
    $('#slider_inner').removeClass();
    $('#slider_inner').addClass("slider_sel_2");
  });

  $(document).on('click', "#slider_btn_3", function(){
    $('#slider_inner').removeClass();
    $('#slider_inner').addClass("slider_sel_3");
  });

  $(document).on('click', "#slider_btn_4", function(){
    $('#slider_inner').removeClass();
    $('#slider_inner').addClass("slider_sel_4");
  });


});