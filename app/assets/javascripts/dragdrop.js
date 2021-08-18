$(document).on('turbolinks:load', function() {

    var el = document.getElementById("sortable_task_0")
    if (el != null){
      var sortable = Sortable.create(el, {
        draggable: '.draggable-item',
        group: {
          name: "shares",
        },
        animation: 250,
        onUpdate: function(evt) {
          // URL用にidを取得
          var item = evt.item;
          var item_id = $(item).attr('value')
          $.ajax({
            url: 'goals/' + item_id + '/sort',
            type: 'patch',
            data: { row_order_position: evt.newIndex, status: false }
          });
        },
        onAdd: function(evt) {
          // URL用にidを取得
          var item = evt.item;
          var item_id = $(item).attr('value')
          // クラス付け替え
          $(item).removeClass('task_1');
          $(item).addClass('task_0');
          $.ajax({
            url: 'goals/' + item_id + '/sort',
            type: 'patch',
            data: { row_order_position: evt.newIndex, status: false }
          });
        }
      })
    }

    var el = document.getElementById("sortable_task_1")
    if (el != null){
      var sortable = Sortable.create(el, {
        draggable: '.draggable-item',
        group: {
          name: "shares",
        },
        animation: 250,
        onUpdate: function(evt) {
          // URL用にidを取得
          var item = evt.item;
          var item_id = $(item).attr('value')
          // ポジションをsortable_task_0も含めて整形
          var count = $('.task_0').length
          var position = count + evt.newIndex
          $.ajax({
            url: 'goals/' + item_id + '/sort',
            type: 'patch',
            data: { row_order_position: position, status: true }
          });
        },
        onAdd: function(evt) {
          // URL用にidを取得
          var item = evt.item;
          var item_id = $(item).attr('value')
          // クラス付け替え
          $(item).removeClass('task_0');
          $(item).addClass('task_1');
          // ポジションをsortable_task_0も含めて整形
          var count = $('.task_0').length
          var position = count + evt.newIndex
          $.ajax({
            url: 'goals/' + item_id + '/sort',
            type: 'patch',
            data: { row_order_position: position, status: true }
          });
        }
      })
    }
});
