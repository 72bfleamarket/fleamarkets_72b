$(function () {
  function likeBuild() {
    let like_breCrru = `<div class="breadCrumbs__lists">
                          <div class="breadCrumbs__lists__list">
                            <a href="/">FURIMA</a>
                            　›　
                            <a href="/users/mypage/2">マイページ</a>
                            　›　
                            <span class="current">cococoのお気に入り一覧</span>
                          </div>
                        </div>`
    return like_breCrru;
  }
  $('#likes-list').on('click', function () {
    let likeid = $(this).val();
    $.ajax({
      url: '/users/mypage/search',
      dataType: 'json',
      type: 'POST',
      data: {
        likes: likeid
      },
    }).done(function (result) {
      $('#likesval').children().remove();
      $('.breadCrumbs').children().remove();
      $('#likesval').html(result.html);
      $(".breadCrumbs").append(likeBuild);
    }).fail(function (err) {
      console.log(err);
    })
  })
})