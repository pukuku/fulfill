// シェア検索でチェックボックスにチェックを入れたイベントを検知し
// jbuilderにてデータ取得後、js内で生成したHTMLを挿入する。
// ↓
// チェックを入れるたびにデータが増えるバグはあるものの動き自体は実装できている。
// バグの修正は可能そうだが、refileの画像を指定できないため今回は見送り


// // $(document).on('turbolinks:load', function() {

// //   $(document).on('click', "#search_status", function(){
// //     let status;
// //     if($(this).prop('checked')){
// //       status = "1";
// //     }else{
// //       status = "";
// //     };
// //     search_sub(status)
// //   });

// //   function search_sub(status){
// //     $.ajax({
// //       type: 'GET',
// //       url: '/shares',
// //       data:{search_status: status},
// //       dataType: 'json'
// //     })
// //     .done(function(data){
// //       data.forEach(function(data){
// //         built_html(data);
// //       });
// //     });
// // }
// //   function built_html(data){
// //     let html = `
// //             <div class="share_block ml-3 mr-2 mt-2 mb-2">
// //               <div class="share_item">
// //                 <a class="share_link" href="/shares/${data.id}"></a>
// //                 <div class="text-center share_text">
// //                   ${data.name}
// //                 </div>
// //                 <div class="text-center share_text">
// //                   ${data.content}
// //                 </div>
// //                 <div class="text-center">
// //                   [${data.category}]
// //                 </div>
// //                 <div class="text-center">
// //                   <p class="fas fa-paperclip"></p>
// //                   ${data.clips}
// //                 </div>
// //               </div>
// //             </div>
// //     `;
// //     $('.built_target').append(html);
// //   }
// // });