  //Comment機能
  $(function(){
    function buildHTML(comment){
      let html = `<div class="comments__box">
                      <a class="comments__box__name" href=/users/profile/${comment.user_id}>${comment.user_name}</a>
                      <div class="comments__box__text">${comment.text}</div>
                    </div>`
      return html;
    }
    function buildOwnerHTML(comment){
      let html = `<div class="comments__box">
                      <a class="comments__box__name" href=/users/profile/${comment.user_id}>${comment.user_name}</a>
                      <div class="comments__box__name__mark">出品者</div>
                      <div class="comments__box__text">${comment.text}</div>
                    </div>`
      return html;
    }
    $('#new_comment').on('submit', function(e){
      e.preventDefault();
      let formData = new FormData(this);
      let url = $(this).attr('action')
      $.ajax({
        url: url,
        type: 'POST',
        data: formData,
        dataType: 'json',
        processData: false,
        contentType: false
      })
      .done(function(data){
        if (data.seller_id == data.user_id) {
          let html = buildOwnerHTML(data);
          $('.comments').append(html).sort();
        } else {
          let html = buildHTML(data);
          $('.comments').append(html).sort();
        }
        $('.comments__box__noComment').remove()
        $('.showMain__content__topContent__commentBox__textField').val('');
        $('.showMain__content__topContent__commentBox__submitBtn').prop('disabled', false);
      })
      .fail(function(){
        alert('error');
      })
    })
  })