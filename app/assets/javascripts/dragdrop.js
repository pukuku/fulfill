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
        var item = evt.item;
        var item_id = $(item).find('.item').attr('value')
        $.ajax({
            url: 'goals/' + item_id + '/sort',
            type: 'patch',
            data: { row_order_position: evt.newIndex, status: false }
          });
        },
        onAdd: function(evt) {
        var item = evt.item;
        var item_id = $(item).find('.item').attr('value')
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
        var item = evt.item;
        var item_id = $(item).find('.item').attr('value')
        $.ajax({
            url: 'goals/' + item_id + '/sort',
            type: 'patch',
            data: { row_order_position: evt.newIndex, status: true }
          });
        },
        onAdd: function(evt) {
        var item = evt.item;
        var item_id = $(item).find('.item').attr('value')
        $.ajax({
            url: 'goals/' + item_id + '/sort',
            type: 'patch',
            data: { row_order_position: evt.newIndex, status: true }
          });
        }
      })
    }

});
