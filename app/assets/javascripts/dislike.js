var railsToDo = railsToDo || {};

railsToDo.fields = ["user_1_id", "user_2_id", "negative_connection"]
var id = $('#relationship').val()


railsToDo.likeNote = function(event){
  event.preventDefault();
  var id = $('#relationship').val()
  if(id==""){
    var method = "POST";
    var path = "/user_connections";
    var data = {user_connections: {'user_1_id': parseInt($('#current_user').val()), 'user_2_id': parseInt($('#this_user').val()), 'negative_connection': false, 'interacted': true }}
  }else{
    var method = "PUT";
    var path = "/user_connections/"+id;
    if($("#like").val()=="true"){
      var bool = false
    }else if($("#like").val()=="false"){
      var bool = true
    }
    var data = {user_connections: {'user_1_id': parseInt($('#current_user').val()), 'user_2_id': parseInt($('#this_user').val()), 'negative_connection': false, 'interacted': bool }}
  }
  $.ajax({
    url: path,
    method: method,
    data: data,
    dataType: "json"
  }).success(function(data){  
    if(data){
      $('#relationship').val(data.id)
    }
    railsToDo.getNotes()
  })
}

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
    if($("#hate").val()=="true"){
      var bool = false
    }else if($("#hate").val()=="false"){
      var bool = true
    }
    if(bool==undefined){
      var bool = true
    }
    var data = {user_connections: {'user_1_id': parseInt($('#current_user').val()), 'user_2_id': parseInt($('#this_user').val()), 'negative_connection': bool }} 
  }
    $.ajax({
      url: path,
      method: method,
      data: data,
      dataType: "json"
    }).success(function(data){
      if(data){
        $('#relationship').val(data.id)
      }
      railsToDo.getNotes()
    })
  }

railsToDo.getNotes = function(){
  var id = $('#relationship').val()
  if(id != ""){
    $.ajax({
      url: "/user_connections/"+id,
      method: "GET",
      dataType: "json",
      success: function(data){
        if(data.interacted==true){
          $("#like").addClass("liked")
          $("#like").val(true)
          $("#hate").addClass("hidden")
          $("#chat").removeClass("hidden")
          return
        }else if(data.interacted==false){
          $("#like").removeClass("liked")
          $("#like").val(false)
          $("#hate").removeClass("hidden")
          $("#chat").removeClass("hidden")
          if(data.negative_connection==true){
            $("#hate").addClass("hated")
            $("#hate").val(true)
            $("#chat").addClass("hidden")
          }else if(data.negative_connection==false){
            $("#hate").removeClass("hated")
            $("#hate").val(false) 
            $("#chat").removeClass("hidden")
          }
        }
      }
    })
  }
}

$(function(){
  railsToDo.getNotes();
  $("#like").on("click", railsToDo.likeNote);
  $("#hate").on("click", railsToDo.postNote)
});