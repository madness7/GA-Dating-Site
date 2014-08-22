var railsChat = railsChat || {};

railsChat.fields = ["username", "other_user", "message"]
// appending all values to the list displayed.  initally deleted so not to repeat.
railsChat.getNotes = function(){
  $("table tbody").html("")
  $.getJSON("/chats", function(data){
    $.each(data, function(i, chat){
      if(chat.user_1_id == $('#current_user').val()){
        if(chat.user_2_id == $('#this_user').val()){
        var row = $("<tr>"+
        "<td>"+ $("#current_user_name").val() +"</td>"+
        "<td>"+ chat.message +"</td></tr>")
      row.appendTo("table tbody")}
    }else if(chat.user_1_id == $('#this_user').val()){
      if(chat.user_2_id == $('#current_user').val()){
          var row = $("<tr>"+
          "<td>"+ $("#this_user_name").val() +"</td>"+
          "<td>"+ chat.message +"</td></tr>")
        row.appendTo("table tbody")}
    }
    })
  })
}
// this is creating a new chat with a user value, reciever value and the message.
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
// updating the chat regularly.
railsChat.updateRegularly = function() {
  setInterval(function() {
    railsChat.getNotes();
  }, 5000);
}
// checking if its the chat page before allowing the update to happen regularly.
$(function(){
  railsChat.getNotes()
  if($("#chat").val()){
    railsChat.updateRegularly();
  }
  $("#new_note").on("submit", railsChat.postNote)
});