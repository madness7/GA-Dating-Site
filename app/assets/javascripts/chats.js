var railsChat = railsChat || {};

railsChat.fields = ["username", "other_user", "message"]

railsChat.getNotes = function(){
  $("table tbody").html("")
  $.getJSON("/chats", function(data){
    $.each(data, function(i, chat){
      if(chat.user_1_id == $('#current_user').val()){
        if(chat.user_2_id == $('#this_user').val()){
        var row = $("<tr>"+
        "<td>"+ chat.user_1_id +"</td>"+
        "<td>"+ chat.message +"</td></tr>")
      row.appendTo("table tbody")}
    }else if(chat.user_1_id == $('#this_user').val()){
      if(chat.user_2_id == $('#current_user').val()){
          var row = $("<tr>"+
          "<td>"+ chat.user_1_id +"</td>"+
          "<td>"+ chat.message +"</td></tr>")
        row.appendTo("table tbody")}
    }
    })
  })
}

railsChat.postNote = function(event){
  event.preventDefault();
  $.ajax({
    url: "/chats",
    method: "POST",
    data: {chat: {'user_1_id': $('#current_user').val(), 'user_2_id': $('#this_user').val(), 'message': $('#message').val()}},
    dataType: "json"
  }).success(function(){railsChat.getNotes()
  })
}

railsChat.updateRegularly = function() {
  setInterval(function() {
    railsChat.getNotes();
  }, 5000);
}

$(function(){
  if($("#chat").val()){
    railsChat.updateRegularly();
  }
  $("#new_note").on("submit", railsChat.postNote)
});