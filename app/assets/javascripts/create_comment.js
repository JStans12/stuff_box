$(document).on('turbolinks:load', function(){
  $('#comment').on('click', function(){

    var fileID = $('#upload_id').val()
    var userID = $('#user_id').val()
    var content = $('#content').val()

    $.ajax({
       type:'POST',
       url: '/uploads/comments',
       data: {upload_id: fileID, user_id: userID, content: content},
       success:function(data) {
         $('#comments').append("<div class='col-sm-6 comment'><div class='panel panel-default'><div class='panel-heading'><strong>" + data["user"]["username"] + "</strong> <span class='text-muted'>" + data["comment"]["created_at"] + "</span></div><div class='panel-body'>" + data["comment"]["content"] + "</div></div></div>")
       }
    });
  });
});
