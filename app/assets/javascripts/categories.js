$(document).on('turbolinks:load', () => {
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
  $('a[href^=#]').click(function () {
    let adjust = 0;
    let speed = 500;
    let href = $(this).attr("href");
    let target = $(href == "#" || href == "" ? 'html' : href);
    let position = target.offset().top + adjust;
    $('body,html').animate({
      scrollTop: position
    }, speed, 'swing');
    return false;
  });

  $("a#scroll_top[href^=#]").click(function () {
    let speeds = 500;
    let hrefTop = $(this).attr("href");
    let targets = $(hrefTop == "#" || hrefTop == "" ? "html" : hrefTop);
    let position = targets.offset().top;

    $("body, html").animate({
      scrollTop: position
    }, speeds, "swing");
    return false;
  });
});