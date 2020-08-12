$(function () {
  function likeBuild(like) {
    let like_breCrru = `<div class="breadCrumbs__lists">
                          <div class="breadCrumbs__lists__list">
                            <a href="/">FURIMA</a>
                            　›　
                            <a href="/users/mypage/${like.id}">マイページ</a>
                            　›　
                            <span class="current">${like.name}さんのお気に入り</span>
                          </div>
                        </div>`
    return like_breCrru;
  }
  $('#likes-list').on('click', function () {
    let valid = $(this).val();
    $.ajax({
        url: '/products/search',
        type: 'GET',
        data: {
          userid: valid
        },
        dataType: 'json'
      })
      .done(function (user) {
        $('.breadCrumbs').children().remove();
        $(".breadCrumbs").append(likeBuild(user[0]));
      })
      .fail(function () {
        console.log('err');
      });

    $.ajax({
        url: '/users/mypage/search',
        type: 'POST',
        data: {
          likes: valid
        },
        dataType: 'json'
      })
      .done(function (result) {
        $('#productsval').children().remove();
        $('#productsval').html(result.html);
      })
      .fail(function () {
        console.log('err');
      });
  });

  function salBuild(saling) {
    let sal_breCrru = `<div class="breadCrumbs__lists">
                          <div class="breadCrumbs__lists__list">
                            <a href="/">FURIMA</a>
                            　›　
                            <a href="/users/mypage/${saling.id}">マイページ</a>
                            　›　
                            <span class="current">${saling.name}さんの出品中</span>
                          </div>
                        </div>`
    return sal_breCrru;
  }
  $('#saling-list').on('click', function () {
    let valid = $(this).val();
    $.ajax({
        url: '/products/search',
        type: 'GET',
        data: {
          userid: valid
        },
        dataType: 'json'
      })
      .done(function (user) {
        $('.breadCrumbs').children().remove();
        $(".breadCrumbs").append(salBuild(user[0]));
      })
      .fail(function () {
        console.log('err');
      });

    $.ajax({
        url: '/users/mypage/search',
        type: 'POST',
        data: {
          saling: valid
        },
        dataType: 'json'
      })
      .done(function (result) {
        $('#productsval').children().remove();
        $('#productsval').html(result.html);
      })
      .fail(function () {
        console.log('err');
      });
  });

  function solBuild(sold) {
    let sol_breCrru = `<div class="breadCrumbs__lists">
                          <div class="breadCrumbs__lists__list">
                            <a href="/">FURIMA</a>
                            　›　
                            <a href="/users/mypage/${sold.id}">マイページ</a>
                            　›　
                            <span class="current">${sold.name}さんの売却済み</span>
                          </div>
                        </div>`
    return sol_breCrru;
  }
  $('#sold-list').on('click', function () {
    let valid = $(this).val();
    $.ajax({
        url: '/products/search',
        type: 'GET',
        data: {
          userid: valid
        },
        dataType: 'json'
      })
      .done(function (user) {
        $('.breadCrumbs').children().remove();
        $(".breadCrumbs").append(solBuild(user[0]));
      })
      .fail(function () {
        console.log('err');
      });

    $.ajax({
        url: '/users/mypage/search',
        type: 'POST',
        data: {
          sold: valid
        },
        dataType: 'json'
      })
      .done(function (result) {
        $('#productsval').children().remove();
        $('#productsval').html(result.html);
      })
      .fail(function () {
        console.log('err');
      });
  });



  function buyedBuild(buyed) {
    let buyed_breCrru = `<div class="breadCrumbs__lists">
                          <div class="breadCrumbs__lists__list">
                            <a href="/">FURIMA</a>
                            　›　
                            <a href="/users/mypage/${buyed.id}">マイページ</a>
                            　›　
                            <span class="current">${buyed.name}さんの購入済み</span>
                          </div>
                        </div>`
    return buyed_breCrru;
  }
  $('#buyed-list').on('click', function () {
    let valid = $(this).val();
    $.ajax({
        url: '/products/search',
        type: 'GET',
        data: {
          userid: valid
        },
        dataType: 'json'
      })
      .done(function (user) {
        $('.breadCrumbs').children().remove();
        $(".breadCrumbs").append(buyedBuild(user[0]));
      })
      .fail(function () {
        console.log('err');
      });

    $.ajax({
        url: '/users/mypage/search',
        type: 'POST',
        data: {
          buyed: valid
        },
        dataType: 'json'
      })
      .done(function (result) {
        $('#productsval').children().remove();
        $('#productsval').html(result.html);
      })
      .fail(function () {
        console.log('err');
      });
  });
});