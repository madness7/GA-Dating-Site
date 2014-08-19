var railsToDo = railsToDo || {};
console.log("hello")

railsToDo.fields = ["user_1_id", "user_2_id", "negative_connection"]
var id = $('#relationship').val()


railsToDo.postNote = function(event){
  event.preventDefault();
  var id = $('#relationship').val()
  if(id == ""){
    var method = "POST";
    var path = "/user_connections";
    var data = {user_connections: {'user_1_id': parseInt($('#current_user').val()), 'user_2_id': parseInt($('#this_user').val()), 'negative_connection': true }} 
  }else{
    
    var method = "PUT";
    var path = "/user_connections/"+id;
    var data = {user_connections: {'user_1_id': parseInt($('#current_user').val()), 'user_2_id': parseInt($('#this_user').val()), 'negative_connection': !($("#hate").val()) }} 
    
  }
    $.ajax({
      url: path,
      method: method,
      data: data,
      dataType: "json"
    }).success(function(){
      railsToDo.getNotes()
    })
  }

railsToDo.getNotes = function(){
  var id = $('#relationship').val()
  if(id != ""){
    $.ajax({
      url: "/user_connections/"+id,
      method: "GET",
      dataType: "json"
    }).success(function(data){
      
      if(data.negative_connection){
        $("#hate").toggleClass("hated")
        if($("#hate").val(true)){
          $("#hate").val(false)
        }else{
          $("#hate").val(true)
        }
        
      }else{
        $("#hate").removeClass("hated")
        $("#hate").val(false)
      }
    })
  }
}

$(function(){
  railsToDo.getNotes();
  $("#hate").on("click", railsToDo.postNote)
});