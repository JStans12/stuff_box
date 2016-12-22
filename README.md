## API

When you sign up for an account with Stuff Box, you will be assigned a token. Any time you make a request to our api, you'll need to send this token along as a parameter. Checkout our list of endpoints below.

POST ```/uploads/comments``` allows you to post a comment on a upload

##### Parameters

| Parameter Name | Description |
| ---------------|:-----------:|
| upload_id      | The id of the file that you want to comment on|
| username       | Your username|
| content        | The body of your comment|
| token          | Your unique user token|

##### Responses

Returns your comment as JSON.
<br>
<br>
<br>

GET ```/uploads/comments``` returns a list of all your personal comments

##### Parameters

| Parameter Name | Description |
| ---------------|:-----------:|
| username       | Your username|
| token          | Your unique user token|

##### Responses

Returns a list receive a a list of all your comments in JSON.
<br>
<br>
<br>

PUT ```/uploads/comment``` allows you to edit a previous comment that you made

##### Parameters

| Parameter Name | Description |
| ---------------|:-----------:|
| comment_id      | The id of the comment that you want to edit|
| username       | Your username|
| content        | The body of your comment|
| token          | Your unique user token|

##### Responses

Returns your edited comment as JSON.
<br>
<br>
<br>

PUT ```/uploads/comment``` allows you to edit a previous comment that you made

##### Parameters

| Parameter Name | Description |
| ---------------|:-----------:|
| comment_id      | The id of the comment that you want to edit|
| username       | Your username|
| token          | Your unique user token|

##### Responses

Returns a success message alerting you that your comment is gone forever.
