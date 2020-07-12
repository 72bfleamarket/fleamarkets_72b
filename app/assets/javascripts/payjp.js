$(function() {
  if ($('#token_submit') !== null) { //token_submitというidがnullの場合、下記コードを実行しない
    Payjp.setPublicKey('pk_test_7e49ae1105fa06e48b7c2075'); //ここに公開鍵を直書き

    let btn = $('#token_submit'); //IDがtoken_submitの場合に取得
    btn.on('click', function(e) { //ボタンが押されたときに作動
      e.preventDefault(); //ボタンを一旦無効
      let card = {//カード情報生成
        number: $('#card_number').val(),
        cvc: $('#cvc').val(),
        exp_month: $('#exp_month').val(),
        exp_year: $('#exp_year').val()
      }; //入力されたデータを取得

      Payjp.createToken(card, function(status, response) {//トークン生成
        if (status === 200) { //成功した場合
          $('#card_number').removeAttr('name');
          $('#cvc').removeAttr('name');
          $('#exp_month').removeAttr('name');
          $('#exp_year').removeAttr('name'); //データを自サーバにpostしないように削除
          $('#card_token').append(
            $('<input type="hidden" name="payjp-token">').val(response.id)
          ); //取得したトークンを送信できる状態
          $('#addCardForm').get(0).submit();
          alert('登録が完了しました'); 
        } else {
          $('#cvc').val('')
          alert('カード情報が正しくありません。');
        }
      });
    });
  }
});