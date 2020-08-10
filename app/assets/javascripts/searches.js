$(document).ready(function () {
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
  $(document).on('click', '.trash-btn', function () {
    $('.keyword-box').remove();
    $(this).hide();
  });

  // クリアボタン
  $(document).on('click', "#grayBtn", function () {
    let searchCheckbox = $('input[type="checkbox"]');
    let searchText = $('input[type="text"]');
    let searchbox = $('input[type="search"]');
    $(searchCheckbox).removeAttr('checked').prop('checked', false).change();
    $(searchText).removeAttr('value').prop('value', '').change();
    $(searchbox).removeAttr('value').prop('value', '').change();
    $("#q_gc_category_id").remove();
    $("#q_cd_category_id").remove();
    $('#q_category_id').prop('selectedIndex', 0);
    $('#q_price').prop('selectedIndex', 0);
  })

  // セレクトボックスでの金額の絞り込み
  $(document).on('change', '#q_price', function () {
    let price = $('[name="q[price]"] option:selected').text();
    let maxRan = /([^( )+]+([0-9][0-9]?)?)$/;
    let ccci = new RegExp(maxRan, 'g');
    let mxArr = price.match(ccci);
    let maxArr = $.trim(mxArr)
    let maArr = maxArr.replace(/,/g, "");
    if (maArr == '選択してください') {
      $('#q_price_lteq').val('');
    } else {
      $("#q_price_lteq").val(maArr);
    }

    let minRan = /[0-9]{1,}([^( )+]+([0-9][0-9]?)?)+[( )+]/
    let fffi = new RegExp(minRan, 'g');
    let mnArr = price.match(fffi);
    let minArr = $.trim(mnArr)
    let miArr = minArr.replace(/,/g, "");
    $("#q_price_gteq").val(miArr);
  });

  //「全て選択」する
  $('#all-cdtion').on('click', function () {
    $("input[name='q[condition_id_eq_any][]']").prop('checked', this.checked);
  });
  // 「全て選択」以外のチェックボックスのアクション
  $(document).on('click', "input[name='q[condition_id_eq_any][]']", function () {
    if ($('.seach_conditon :checked').length == $('.seach_conditon').children().length) {
      $('#all-cdtion').prop('checked', true);
    } else {
      $('#all-cdtion').prop('checked', false);
    }
  });
  //「全て選択」する
  $('#all-postage').on('click', function () {
    $("input[name='q[postage_id_eq_any][]']").prop('checked', this.checked);
  });
  // 「全て選択」以外のチェックボックスのアクション
  $(document).on('click', "input[name='q[postage_id_eq_any][]']", function () {
    if ($('.seach_postage :checked').length == $('.seach_postage').children().length) {
      $('#all-postage').prop('checked', true);
    } else {
      $('#all-postage').prop('checked', false);
    }
  });

  $(document).on('click', "input[name='q[buyer_id_null]']", function () {
    $('#buyer-true').prop('checked', false);
  });

  $(document).on('click', "input[name='q[buyer_id_not_null]']", function () {
    $('#buyer-false').prop('checked', false);
  });

  function build_childSelect() {
    let q_child_select = `
                          <select name="q[category_id_in]" id="q_cd_category_id">
                            <option value="">すべて</option>
                          </select>
                          `
    return q_child_select;
  }

  function build_Option(children) {
    let option_html = `
    <option value=${children.id}>${children.name}</option>
    `
    return option_html;
  }

  function build_gcSelect() {
    let q_gc_select = `
                      <select name="q[category_id_in]" id="q_gc_category_id">
                        <option value="">すべて</option>
                      </select>
                      `
    return q_gc_select;
  }

  // 親セレクトを変更したらjQueryが発火する
  $("#q_category_id").change(function () {
    let parentVal = $("#q_category_id").val();
    if (parentVal != "") {
      $.ajax({
          url: '/products/search',
          type: 'GET',
          data: {
            parent_id: parentVal
          },
          dataType: 'json'
        })
        .done(function (data) {
          let q_child_select = build_childSelect
          $("#q_gc_category_id").remove();
          $("#q_cd_category_id").remove();
          $(".formGroup__selectWrap--categories").append(q_child_select);
          data.forEach(function (d) {
            let option_html = build_Option(d)
            $("#q_cd_category_id").append(option_html);
          });
        })
        .fail(function () {
          alert("カテゴリーを選択してください");
        });
    } else {
      $("#q_gc_category_id").remove();
      $("#q_cd_category_id").remove();
    }
  });
  // 子セレクトを変更したらjQueryが発火する
  $(document).on("change", "#q_cd_category_id", function () {
    let childVal = $("#q_cd_category_id").val();
    if (childVal != "") {
      $.ajax({
          url: '/products/search',
          type: 'GET',
          data: {
            children_id: childVal
          },
          dataType: 'json'
        })
        .done(function (gc_data) {
          let q_gc_select = build_gcSelect
          $("#q_gc_category_id").remove();
          $(".formGroup__selectWrap--categories").append(q_gc_select);
          gc_data.forEach(function (gc_d) {
            let option_html = build_Option(gc_d);
            $("#q_gc_category_id").append(option_html);
          });
        })
        .fail(function () {
          alert("カテゴリーを選択してください");
        });
    } else {
      $("#q_gc_category_id").remove();
    }
  });
  // 絞り込みリストの並べ替え
  $(document).on('change', '#q_sorts', function () {
    if ($('#q_gc_category_id').val() == "") {
      $('#q_gc_category_id').remove();
    } else if ($('#q_cd_category_id').val() == "") {
      $('#q_cd_category_id').remove();
    }
    $("#product_search").submit();
  });

  // カテゴリーセレクトの処理
  $(document).on('click', "#redBtn", function () {
    if ($('#q_gc_category_id').val() == "") {
      $('#q_gc_category_id').remove();
    } else if ($('#q_cd_category_id').val() == "") {
      $('#q_cd_category_id').remove();
    }
  });

  // 全てを探すボタンの処理
  $(document).on('click', "#search_alls", function () {
    $('#grayBtn').trigger('click');
    $("#product_search").submit();
  });

  // ページ読み込み時のカテゴリー処理
  if ($('#q_cd_category_id').val() != "" && !$('#q_gc_category_id').length) {
    $('#q_cd_category_id').trigger('change');
  }
  if ($('#q_category_id').val() != "" && !$('#q_cd_category_id').length) {
    $('#q_category_id').trigger('change');
  }
});