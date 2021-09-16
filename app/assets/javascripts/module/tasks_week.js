$(document).on("turbolinks:load", function() {

  // ロード時
  $(".week_tab li:first-of-type").addClass("active");
  $(".area:first-of-type").addClass("is-active");
  var hash_name = location.hash;
  get_hash (hash_name);

  function get_hash (hash_data){
    if(hash_data){
      $(".week_tab li").find("a").each(function() {
        var id_name = $(this).attr("href");
        if(id_name == hash_data){
          var parentElm = $(this).parent();
          $(".week_tab li").removeClass("active");
          $(parentElm).addClass("active");
          $(".area").removeClass("is-active");
          $(hash_data).addClass("is-active");
        }
      });
    }
  }

  //タブをクリックしたら
  $(".week_tab a").on("click", function() {
    var id_name = $(this).attr("href");
    get_hash (id_name);
    return false;
  });

});
