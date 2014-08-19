$(function(){
  $("#hate").on("click", function(event){
    event.preventDefault();
    $.ajax({
      url: "/user_connections",
      method: "POST",
      data: {user_connections: {'user_1_id': parseInt($('#current_user').val()), 'user_2_id': parseInt($('#this_user').val()), 'negative_connection': true }},
      dataType: "json"
    }).success(function(){
      $("#hate").css({"background-color": "red"})
    })
  })
});