var railsToDo = railsToDo || {};

railsToDo.fields = ["user_1_id", "user_2_id", "negative_connection"]



railsToDo.postNote = function(event){
    event.preventDefault();
    $.ajax({
      url: "/user_connections",
      method: "POST",
      data: {user_connections: {'user_1_id': parseInt($('#current_user').val()), 'user_2_id': parseInt($('#this_user').val()), 'negative_connection': true }},
      dataType: "json"
    }).success(function(){
      $("#hate").css({"background-color": "red"})
    })
  }

railsToDo.getNotes = function(){
  var id = $('#current_user').val()
  $.getJSON("/user_connections/"+id, function(data){
    $.each(data, function(i, note){
      }
    )
  })
}

$(function(){
  railsToDo.getNotes();
  $("#hate").on("click", railsToDo.postNote)
});