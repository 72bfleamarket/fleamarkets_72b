$(document).on('turbolinks:load', () => {
  // const buildFileField = (num) => {
  //   const html = `<div class="js-file_group" data-index="${num}">
  //                   <input class="js-file" type="file" name="product[images_attributes][${num}][item]" id="product_images_attributes_${num}_item">
  //                 </div>`;
  //   return html;
  // }
  // const buildImg = (index, url) => {
  //   const html = `<img data-index="${index}" src="${url}" width="100px" height="100px">`;
  //   return html;
  // }

  // let fileIndex = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  // lastIndex = $('.js-file_group:last').data('index');
  // fileIndex.splice(0, lastIndex);
  // $('.hidden-destroy').hide();

  // //画像を追加
  // $('#products-image').on('change', '.js-file', function (e) {
  //   const targetIndex = $(this).parent().data('index');
  //   const file = e.target.files[0];
  //   const blobUrl = window.URL.createObjectURL(file);
  //   if (img = $(`img[data-index="${targetIndex}"]`)[0]) {
  //     img.setAttribute('src', blobUrl);
  //   } else {
  //     $('#previews').append(buildImg(targetIndex, blobUrl));
  //     $('#products-image').append(buildFileField(fileIndex[0]));
  //     fileIndex.shift();
  //     fileIndex.push(fileIndex[fileIndex.length - 1] + 1);
  //     $(this).after('<span class="js-remove">削除</span>');
  //   }
  // });

  // //画像を削除
  // $('#products-image').on('click', '.js-remove', function () {
  //   const targetIndex = $(this).parent().data('index');
  //   const hiddenCheck = $(`input[data-index="${targetIndex}"].hidden-destroy`);
  //   if (hiddenCheck) hiddenCheck.prop('checked', true);
  //   $(this).parent().remove();
  //   $(this).remove();
  //   const image = $(`#product_images_attributes_${targetIndex}_item`);
  //   image.remove();
  //   $(`img[data-index="${targetIndex}"]`).remove();
  //   if ($('.js-file').length == 0) $('#products-image').append(buildFileField(fileIndex[0]));
  // });


  //test1
  $(function(){
    //画像ファイルプレビュー表示のイベント追加 fileを選択時に発火するイベントを登録
    $('.box').on('change', 'input[type="file"]', function(e) {
      var file = e.target.files[0];
      reader = new FileReader();
      var preview1 = $(".box-preview__1");
      var preview2 = $(".box-preview__2");
      var dropbox1 = $(".box-field__1");
      var dropbox2 = $(".box-field2__2");
      var box2 = $(".box-field2");
      var inputs  =[];

      
      t = this;
      
      // 画像ファイル判別し画像ファイル以外はfalse
      if(file.type.indexOf("image") < 0){
        return false;
      }
        // ファイル読み込みが完了した際のイベント登録
      reader.onload = (function(file) {
        return function(e) {
          var src = reader.result
          var html= `<div class='preview' data-image="${file.name}">
          <div class=' preview__content'>
          <img src=${src} width="134" height="75" >
          </div>
          <div class='preview__delete', id='back'>削除</div>
          </div>`
          //box要素の前にhtmlを差し込む
          if($(".preview").length <= 4){
          preview1.append(html);
          console.log("a")
          console.log($(".preview").length)
        }else{
              preview2.append(html);
            }
        if($(".preview").length >= 5) {
          dropbox2.css({'display': 'block'})
          dropbox1.css({'display': 'none'})
          console.log("b")
            // console.log($(".preview").length)
          };
          if ($(".preview").length == 10){
            dropbox2.css({'display': 'none'})
          }
          // if($(".preview").length > 5) {
          //   preview2.append(html);
          //   console.log($(".preview").length)

          // }
            //画像を削除
            $(document).on("click", '.preview__delete', function(){
              //プレビュー要素を取得
              var target_image = $(this).parent()

              //プレビューを削除
              target_image.remove();
              console.log($(".preview").length)

              if ($(".preview").length <= 4) {
                dropbox1.css({'display': 'block'})
                dropbox2.css({'display': 'none'})
              }else{
                dropbox2.css({'display': 'block'})
                dropbox1.css({'display': 'none'})
              }
              
            })
            }
        })
        (file);
        reader.readAsDataURL(file);
        

    });



    // $('.preview__delete').on('click', function() {
    //   $('.box-field').removeClass('change');
    // });

  });
  $(function(){
});
  


  //文字数をカウント
  $('#count_name').on('input', function () {
    const count = $(this).val().length;
    $('.up_count').text(count);
  });
  $('#count_area').on('input', function () {
    const count = $(this).val().length;
    $('.up_counter').text(count);
  });
  //再読み込み時の文字数をカウント
  $('#count_name').trigger('input');
  $('#count_area').trigger('input');
});