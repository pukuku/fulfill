$(document).on('turbolinks:load', function() {
  function GethashID (hashIDName){
    if(hashIDName){
      $('.week_tab li').find('a').each(function() {
        var idName = $(this).attr('href');
        if(idName == hashIDName){
          var parentElm = $(this).parent();
          $('.week_tab li').removeClass("active");
          $(parentElm).addClass("active");
          $(".area").removeClass("is-active");
          $(hashIDName).addClass("is-active");
        }
      });
    }
  }
  //タブをクリックしたら
  $('.week_tab a').on('click', function() {
    var idName = $(this).attr('href');
    GethashID (idName);
    return false;
  });


  // ロード時
  $(window).on('load', function () {
    $('.week_tab li:first-of-type').addClass("active");
    $('.area:first-of-type').addClass("is-active");
    var hashName = location.hash;
    GethashID (hashName);
  });
});
