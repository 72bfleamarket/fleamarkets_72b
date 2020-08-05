$(function () {
  function buildKeyword(word) {
    let keyword_select = `<li class="keyword-box">
                            <input class="keyword_search" name="${word.id}" type="button" value="${word.name}">
                          </li>
                          `
    return keyword_select;
  }

  function build_brand(word) {
    let keyword_select = `<li class="keyword-box">
                            <input class="keyword_search" name="${word.id}" type="button" value="${word.brand}">
                          </li>
                          `
    return keyword_select;
  }

  function build_category(word) {
    let keyword_select = `<li class="keyword-box">
                            <input class="keyword_search" name="${word.id}" type="button" value="${word.name}">
                          </li>
                          `
    return keyword_select;
  }

  function build_trash() {
    let keyword_select = `<li class="trash-btn">
                            <i class="fas fa-trash-alt trash"></i>
                          </li>
                          `
    return keyword_select;
  }

  // インクリメンタルサーチのイベント発火
  $("#search-input").on("keyup", function () {
    let inputSearch = $("#search-input").val();
    $.ajax({
        type: 'GET',
        url: '/products/search',
        data: {
          keyword: inputSearch
        },
        dataType: 'json'
      })
      .done(function (keydata) {
        $("#keyword").empty();
        if (keydata.length !== 0) {
          $(".keyword-box").remove();
          keydata.forEach(function (keyword) {
            let searchs = $("#search-input").val().split(/( |　)+/);
            let product_html = buildKeyword(keyword);
            let brand_html = build_brand(keyword);
            let category_html = build_category(keyword);
            let wordProduct = $(product_html).children().val().split(/( |　)+/);
            let wordBrand = $(brand_html).children().val().split(/( |　)+/);
            let wordCategory = $(category_html).children().val().split(/( |　)+/);
            let ser = searchs.filter(function (s) {
              return s !== "";
            });
            // OR条件でマッチしている商品名、ブランド、カテゴリーを探す
            ser.forEach(function (sh) {
              wordProduct.forEach(function (p) {
                if (p.indexOf(sh) > -1) {
                  $('#keyword').append(product_html);
                }
              })
              wordBrand.forEach(function (b) {
                if (b.indexOf(sh) > -1) {
                  $('#keyword').append(brand_html);
                }
              })
              wordCategory.forEach(function (c) {
                if (c.indexOf(sh) > -1) {
                  $('#keyword').append(category_html);
                }
              })
            })
          })
        }
        // 重複した候補の削除
        $('.keyword_search').filter(
          function () {
            let btnVal = $(this).val();
            return this !== $(`.keyword_search[value^="${btnVal}"]`).get(0);
          }
        ).parent().remove();
        // 候補がある場合にキーワード候補の削除ボタンの表示
        if ($('.keyword_search').length > 0) {
          $('#keyword').append(build_trash);
        } else {
          $(".keyword-box").remove();
        }
      })
      .fail(function () {
        alert("検索に失敗しました");
      });
  });
  // 候補リストを検索欄に追加
  $(document).on('click', '.keyword_search', function () {
    let wordBtn = $(this).val();
    let wordSear = $("#search-input").val();
    let lastword = wordSear.replace(/[^( |　)+\S*$]|\S*$/, wordBtn);
    $("#search-input").val(lastword + " ");
    // $('#search-input').trigger('keyup');
  });
  // 候補リストを削除
  $(document).on('click', '.trash', function () {
    $(".keyword-box").remove();
    $(this).parent().remove();
  });
});