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


  //Drag&Drop
  $(function(){
    const buildFileField =(num) => {
      const field = `<label class="box-field field-${num}" data-index="${num}">
                        <i class="fas fa-camera"></i>
                        <input class="box__select" type="file" name="product[images_attributes][${num}][item]" id="product_images_attributes_${num}_item">
                      </label>`;
      return field;
    }

    // let fileIndex = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
    // lastIndex = $('.box-field:last').data('index');

    //画像ファイルプレビュー表示のイベント追加 fileを選択時に発火するイベントを登録
    $('.box').on('change', 'input[type="file"]', function(e) {
      const targetIndex = $(this).parent().data('index');
      const file = e.target.files[0];
      reader = new FileReader();
      const dropbox = $(".box-field");
      var box = $(".box");
      const images_no = dropbox.length
      // 画像ファイル判別し画像ファイル以外はfalse
      if(file.type.indexOf("image") < 0){
        return false;
      }
        // ファイル読み込みが完了した際のイベント登録
      reader.onload = (function(file) {
        return function(e) {
          var src = reader.result
          console.log(images_no)
          var html= `<div class='preview img-${images_no}' data-image="${file.name}">
          <div class='preview__content'>
          <img src=${src} width="134" height="75" >
          </div>
          <div class='preview__delete', id='back'>削除</div>
          </div>`

          //box要素の前にhtmlを差し込む
          dropbox.before(html);
          // var num = fileIndex.shift();
          box.append(buildFileField(images_no));


          //写真追加によるviewの変更
          if (images_no == 10){
            dropbox.css({'display': 'none'})
            $(".field-0").css({'display': 'none'})
            $(".field-1").css({'display': 'none'})
            $(".field-2").css({'display': 'none'})
            $(".field-3").css({'display': 'none'})
            $(".field-4").css({'display': 'none'})
            $(".field-5").css({'display': 'none'})
            $(".field-6").css({'display': 'none'})
            $(".field-7").css({'display': 'none'})
            $(".field-8").css({'display': 'none'})
            $(".field-9").css({'display': 'none'})
          }else{
            dropbox.css({'display': 'block'})
          }
          if(images_no == 9) {
            dropbox.css({'width': '20%'})
            $(".field-0").css({'display': 'none'})
            $(".field-1").css({'display': 'none'})
            $(".field-2").css({'display': 'none'})
            $(".field-3").css({'display': 'none'})
            $(".field-4").css({'display': 'none'})
            $(".field-5").css({'display': 'none'})
            $(".field-6").css({'display': 'none'})
            $(".field-7").css({'display': 'none'})
            $(".field-8").css({'display': 'none'})
          }
          if(images_no == 8) {
            dropbox.css({'width': '40%'})
            $(".field-0").css({'display': 'none'})
            $(".field-1").css({'display': 'none'})
            $(".field-2").css({'display': 'none'})
            $(".field-3").css({'display': 'none'})
            $(".field-4").css({'display': 'none'})
            $(".field-5").css({'display': 'none'})
            $(".field-6").css({'display': 'none'})
            $(".field-7").css({'display': 'none'})
          }
          if(images_no == 7) {
            dropbox.css({'width': '60%'})
            $(".field-0").css({'display': 'none'})
            $(".field-1").css({'display': 'none'})
            $(".field-2").css({'display': 'none'})
            $(".field-3").css({'display': 'none'})
            $(".field-4").css({'display': 'none'})
            $(".field-5").css({'display': 'none'})
            $(".field-6").css({'display': 'none'})
          }
          if(images_no == 6) {
            dropbox.css({'width': '80%'})
            $(".field-0").css({'display': 'none'})
            $(".field-1").css({'display': 'none'})
            $(".field-2").css({'display': 'none'})
            $(".field-3").css({'display': 'none'})
            $(".field-4").css({'display': 'none'})
            $(".field-5").css({'display': 'none'})
          }
          if(images_no == 5) {
            dropbox.css({'width': '100%'})
            $(".field-0").css({'display': 'none'})
            $(".field-1").css({'display': 'none'})
            $(".field-2").css({'display': 'none'})
            $(".field-3").css({'display': 'none'})
            $(".field-4").css({'display': 'none'})
            }
          if(images_no == 4) {
            dropbox.css({'width': '20%'})
            $(".field-0").css({'display': 'none'})
            $(".field-1").css({'display': 'none'})
            $(".field-2").css({'display': 'none'})
            $(".field-3").css({'display': 'none'})
            }
          if(images_no == 3) {
            dropbox.css({'width': '40%'})
            $(".field-0").css({'display': 'none'})
            $(".field-1").css({'display': 'none'})
            $(".field-2").css({'display': 'none'})
            // $(".img-2").css({'display': 'none'})
          }
          if(images_no == 2) {
            dropbox.css({'width': '60%'})
            $(".field-0").css({'display': 'none'})
            $(".field-1").css({'display': 'none'})
            // $(".img-1").css({'display': 'none'})
          }
          if(images_no == 1) {
            dropbox.css({'width': '80%'})
            $(".field-0").css({'display': 'none'})
            }
          if(images_no == 0) {
            dropbox.css({'width': '100%'})
            }

          //削除ボタンを押下した際の画像削除イベント
          $(document).on("click", '.preview__delete', function(){
            //Preview要素を取得
            var target_image = $(this).parent()

            //Preview要素を削除
            target_image.remove();
            console.log($(".preview").length)

            //写真追加によるviewの変更
            if ($(".preview").length <= 9) {
              dropbox.css({'display': 'block'})
            }
            if($(".preview").length == 9) {
              dropbox.css({'width': '20%'})
            }
            if($(".preview").length == 8) {
              dropbox.css({'width': '40%'})
            }
            if($(".preview").length == 7) {
              dropbox.css({'width': '60%'})
            }
            if($(".preview").length == 6) {
              dropbox.css({'width': '80%'})
            }
            if($(".preview").length == 5) {
              dropbox.css({'width': '100%'})
              }
            if($(".preview").length == 4) {
              dropbox.css({'width': '20%'})
              }
            if($(".preview").length == 3) {
              dropbox.css({'width': '40%'})
              }
            if($(".preview").length == 2) {
              dropbox.css({'width': '60%'})
              }
            if($(".preview").length == 1) {
              dropbox.css({'width': '80%'})
              }
            if($(".preview").length == 0) {
              dropbox.css({'width': '100%'})
              }
            })
          }
        })
        (file);
        reader.readAsDataURL(file);
        console.log(reader)
    });
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