$(document).on('turbolinks:load', function(){
  $('#comment').on('click', function(){
    var fileID = document.getElementById('upload_id').value
    var userID = document.getElementById('user_id').value
    var content = document.getElementById('content').value

    $.ajax({
       type:'POST',
       url: '/upload/comments',
       data: {file: fileID, user: userID, content: content}
    });
  });
});
