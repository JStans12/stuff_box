$(document).on('turbolinks:load', function(){
  $('#comment').on('click', function(){

    var fileID = $('#upload_id').val()
    var username = $('#username').val()
    var content = $('#content').val()
    var token = $('#token').val()

    $.ajax({
       type:'POST',
       url: '/uploads/comments',
       data: {upload_id: fileID, username: username, content: content, token: token},
       success:function(data) {
         $('#comments').append("<div class='col-sm-6 comment'><div class='panel panel-default'><div class='panel-heading'><strong>" + data["username"] + "</strong> <span class='text-muted'>" + data["created_at"] + "</span></div><div class='panel-body'>" + data["content"] + "</div></div></div>")
       }
    });
  });
});
