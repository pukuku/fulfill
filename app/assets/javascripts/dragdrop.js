$(document).on('turbolinks:load', function() {

  $(document).ready(function(){
    function dragEnd(evt) {　//受け取り
    }

    var el = document.getElementById("sortable_task_0")
    var sortable = Sortable.create(el, {
      draggable: '.draggable-item',  //ドラッグ可能領域
      group: {
        name: "shares",　//グループ名（これにより複数の表間を移動できる）
      },
      animation: 250,
      onUpdate: function(evt) {　//リスト内に新たに要素が追加されたとき
      $.ajax({
          url: 'goals/' + $("#goal_id").val() + '/sort',
          type: 'patch',
          data: { from: evt.oldIndex, to: evt.newIndex }
        });
      }
    })



    var el = document.getElementById("sortable_task_1")
    var sortable = Sortable.create(el, {
      draggable: '.draggable-item',
      group: {
        name: "shares",
      },
      animation: 250,
      onAdd: function(evt) {
      var id = $("#goal_id").val()
      $.ajax({
          url: 'goals/' + $("#goal_id").val() + '/sort',
          type: 'patch',
          data: {to: evt.newIndex }
        });
      }
    })
  });
});
