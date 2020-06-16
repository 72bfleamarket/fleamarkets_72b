$(document).on('turbolinks:load', () => {
  const buildFileField = (num) => {
    const html = `<div class="js-file_group" data-index="${num}">
                    <input class="js-file" type="file" name="product[images_attributes][${num}][item]" id="product_images_attributes_${num}_item">
                  </div>`;
    return html;
  }
  const buildImg = (index, url) => {
    const html = `<img data-index="${index}" src="${url}" width="100px" height="100px">`;
    return html;
  }

  let fileIndex = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  lastIndex = $('.js-file_group:last').data('index');
  fileIndex.splice(0, lastIndex);


  $('.hidden-destroy').hide();
  // $('.js-file').after('<span class="js-remove">削除</span>');

  $('#products-image').on('change', '.js-file', function (e) {
    const targetIndex = $(this).parent().data('index');
    const file = e.target.files[0];
    const blobUrl = window.URL.createObjectURL(file);

    if (img = $(`img[data-index="${targetIndex}"]`)[0]) {
      img.setAttribute('src', blobUrl);
    } else {
      $('#previews').append(buildImg(targetIndex, blobUrl));
      $('#products-image').append(buildFileField(fileIndex[0]));
      fileIndex.shift();
      fileIndex.push(fileIndex[fileIndex.length - 1] + 1);
      $(this).after('<span class="js-remove">削除</span>');
    }
  });

  $('#products-image').on('click', '.js-remove', function () {
    const targetIndex = $(this).parent().data('index');
    console.log(targetIndex)
    const hiddenCheck = $(`input[data-index="${targetIndex}"].hidden-destroy`);
    if (hiddenCheck) hiddenCheck.prop('checked', true);

    $(this).parent().remove();
    $(this).remove();
    const image = $(`#product_images_attributes_${targetIndex}_item`);
    image.remove();

    $(`img[data-index="${targetIndex}"]`).remove();
    if ($('.js-file').length == 0) $('#products-image').append(buildFileField(fileIndex[0]));
  });
});