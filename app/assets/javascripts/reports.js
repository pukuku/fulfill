    $(document).on('turbolinks:load', function () {

    $(document).on('click', ".report_modal_close", function(){
      $('.report_modal').removeClass('report_modal-active');
      $('.report_mask').removeClass('report_mask-active');
    });

    $(document).on('click', ".report_mask-active", function(){
      $('.report_modal-active').removeClass('report_modal-active');
      $('.report_mask-active').removeClass('report_mask-active');
    });


    if ($('#calendar').length == 1) {
      var url = location.pathname

      function Calendar() {
        return $('#calendar').fullCalendar({
        });
      }
      function clearCalendar() {
        $('#calendar').html('');
      }

      $(document).on('turbolinks:load', function () {
        Calendar();
      });
      $(document).on('turbolinks:before-cache', clearCalendar);

      //events: '/events.json', 以下に追加
      $('#calendar').fullCalendar({
        events: `${url}.json`,
        //カレンダー上部を年月で表示させる
        titleFormat: 'YYYY年 M月',
        //曜日を日本語表示
        dayNamesShort: ['日', '月', '火', '水', '木', '金', '土'],
        //ボタンのレイアウト
        header: {
          left: 'prev',
          center: 'title',
          right: 'next'
        },
        //終了時刻がないイベントの表示間隔
        buttonText: {
          prev: '<<',
          next: '>>'
        },
        // Drag & Drop & Resize
        // editable: true,
        //イベントの時間表示を２４時間に
        timeFormat: "HH:mm",
        //イベントの色を変える
        eventColor: '#ccff66',
        //イベントの文字色を変える
        eventTextColor: '#000000',
        eventRender: function(event, element) {
          element.css("font-size", "0.8em");
          element.css("padding", "5px");
        },
        // 日付クリックでモーダル表示
        eventClick: function(calEvent, jsEvent, view) {
          var report_id = calEvent.id
          $.ajax({
            url: 'reports/' + report_id ,
            type: 'get',
          });
        }
      });
    }
  });












