$(document).ready(function () {
  function build_childSelect() {
    let child_select = `
                        <select name="product[category_id]" class="child_category_id">
                          <option value="">---</option>
                        </select>
                        `
    return child_select;
  }

  function build_Option(children) {
    let option_html = `
                      <option value=${children.id}>${children.name}</option>
                      `
    return option_html;
  }

  function build_gcSelect() {
    let gc_select = `
                    <select name="product[category_id]" class="gc_category_id">
                      <option value="">---</option>
                    </select>
                    `
    return gc_select;
  }

  // 親セレクトを変更したらjQueryが発火する
  $("#category_form").change(function () {
    let parentValue = $("#category_form").val();
    if (parentValue != "---") {
      $.ajax({
          url: '/products/search',
          type: 'GET',
          data: {
            parent_id: parentValue
          },
          dataType: 'json'
        })
        .done(function (data) {
          let child_select = build_childSelect
          $(".child_category_id").remove();
          $(".gc_category_id").remove();
          $("#category_field").append(child_select);
          data.forEach(function (d) {
            let option_html = build_Option(d)
            $(".child_category_id").append(option_html);
          })
        })
        .fail(function () {
          alert("カテゴリーを選択してください");
        });
    } else {
      $(".child_category_id").remove();
      $(".gc_category_id").remove();
    }
  });
  // 子セレクトを変更したらjQueryが発火する
  $(document).on("change", ".child_category_id", function () {
    let childValue = $(".child_category_id").val();
    if (childValue != "---") {
      $.ajax({
          url: '/products/search',
          type: 'GET',
          data: {
            children_id: childValue
          },
          dataType: 'json'
        })
        .done(function (gc_data) {
          let gc_select = build_gcSelect
          $(".gc_category_id").remove();
          $("#category_field").append(gc_select);
          gc_data.forEach(function (gc_d) {
            let option_html = build_Option(gc_d);
            $(".gc_category_id").append(option_html);
          });
        })
        .fail(function () {
          alert("カテゴリーを選択してください");
        });
    } else {
      $(".child_category_id").remove();
      $(".gc_category_id").remove();
    }
  });

  // ページ内リンクのスクロール
  $('a#scroll_top[href^="#"]').click(function () {
    let speedTop = 400;
    let hrefTop = $(this).attr("href");
    let targets = $(hrefTop == "#" || hrefTop == "" ? "html" : hrefTop);
    let position = targets.offset().top;
    $("body, html").animate({
      scrollTop: position
    }, speedTop, "swing");
    return false;
  });

  $('a[href^="#"]').click(function () {
    let adjust = 0;
    let speed = 3000;
    let href = $(this).attr("href");
    let target = $(href == "#" || href == "" ? 'html' : href);
    let position = target.offset().top + adjust;
    $('body,html').animate({
      scrollTop: position
    }, speed, 'swing');
    return false;
  });

  $('#sub_category').click(function () {
    $('#sub_category').hide();
    $('#categories-lists').show();
  });

  $('#close_category').click(function () {
    $('#categories-lists').hide();
    $('#sub_category').show();
  });

  // ブラウザバック時に強制的にイベントを発火
  $('#close_category').trigger('click');


  // 非同期にてヘッダーのカテゴリーを表示
  function childBuild(children) {
    let child_category = `
                        <li class="category_child">
                          <a href="/categories/${children.id}"><input class="child_btn" type="button" value="${children.name}" name= "${children.id}">
                          </a>
                        </li>
                        `
    return child_category;
  }

  function gcBuild(children) {
    let gc_category = `
                        <li class="category_grandchild">
                          <a href="/categories/${children.id}"><input class="gc_btn" type="button" value="${children.name}" name= "${children.id}">
                          </a>
                        </li>
                        `
    return gc_category;
  }

  // 親カテゴリーを表示
  $('#categoBtn').hover(function (e) {
    e.preventDefault();
    e.stopPropagation();
    timeOut = setTimeout(function () {
      $('#tree_menu').show();
      $('.categoryTree').show();
    }, 500)
  }, function () {
    clearTimeout(timeOut)
  });

  // 子カテゴリーを表示
  $('.parent_btn').hover(function () {
    let categoryParent = $(this).attr('name');
    timeParent = setTimeout(function () {
      $.ajax({
          url: '/products/search',
          type: 'GET',
          data: {
            parent_id: categoryParent
          },
          dataType: 'json'
        })
        .done(function (data) {
          $(".categoryTree-grandchild").hide();
          $(".category_child").remove();
          $(".category_grandchild").remove();
          $('.categoryTree-child').show();
          data.forEach(function (child) {
            let child_html = childBuild(child)
            $(".categoryTree-child").append(child_html);
          });
          $('#tree_menu').css('max-height', '490px');
        })
        .fail(function () {
          alert("カテゴリーを選択してください");
        });
    }, 500)
  }, function () {
    clearTimeout(timeParent);
  });

  // 孫カテゴリーを表示
  $(document).on({
    mouseenter: function () {
      let categoryChild = $(this).attr('name');
      timeChild = setTimeout(function () {
        $.ajax({
            url: '/products/search',
            type: 'GET',
            data: {
              children_id: categoryChild
            },
            dataType: 'json'
          })
          .done(function (gc_data) {
            $(".category_grandchild").remove();
            $('.categoryTree-grandchild').show();
            gc_data.forEach(function (gc) {
              let gc_html = gcBuild(gc)
              $(".categoryTree-grandchild").append(gc_html);
            });
            $('#tree_menu').css('max-height', '490px');
          })
          .fail(function () {
            alert("カテゴリーを選択してください");
          });
      }, 500)
    },
    mouseleave: function () {
      clearTimeout(timeChild);
    }
  }, '.child_btn');

  // カテゴリー一覧ページのボタン
  $('#all_btn').hover(function (e) {
    e.preventDefault();
    e.stopPropagation();
    $(".categoryTree-grandchild").hide();
    $(".categoryTree-child").hide();
    $(".category_grandchild").remove();
    $(".category_child").remove();
  }, function () {
    // あえて何も記述しないことで親要素に外れた際のアクションだけを伝搬する
  });

  // カテゴリーを非表示(カテゴリーメニュから0.8秒以上カーソルを外したら消える)
  $(document).on({
    mouseleave: function (e) {
      e.stopPropagation();
      e.preventDefault();
      timeChosed = setTimeout(function () {
        $(".categoryTree-grandchild").hide();
        $(".categoryTree-child").hide();
        $(".categoryTree").hide();
        $(this).hide();
        $(".category_child").remove();
        $(".category_grandchild").remove();
      }, 800);
    },
    mouseenter: function () {
      $('.categoryTree').show();
      clearTimeout(timeChosed);
    }
  }, '#tree_menu');

  // カテゴリーボタンの処理
  let timeOpened = setTimeout(function () {
    $('#tree_menu').show();
    $('.categoryTree').show();
  }, 500);
  $(document).on({
    mouseenter: function (e) {
      e.stopPropagation();
      e.preventDefault();
    },
    mouseleave: function (e) {
      e.stopPropagation();
      e.preventDefault();
      clearTimeout(timeOpened);
      $(".categoryTree-grandchild").hide();
      $(".categoryTree-child").hide();
      $(".categoryTree").hide();
      $("#tree_menu").hide();
      $(".category_child").remove();
      $(".category_grandchild").remove();
    }
  }, '.header__headerInner__nav__listsLeft__item');

  console.log('hoge');
  // ブラウザバック時に強制的に非表示イベントを発火
  $('.header__headerInner__nav__listsLeft__item').trigger('mouseleave');
});