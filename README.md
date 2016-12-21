## API

When you sign up for an account with Stuff Box, you will be assigned a token. Any time you make a request to our api, you'll need to send this token along as a parameter. Checkout our list of endpoints below.

```/uploads/comments``` allows you to post a comment on a upload

##### Parameters

| Parameter Name | Description |
| ---------------|:-----------:|
| upload_id      | The id of the file that you want to comment on|
| user_id        | Your user id|
| content        | The body of your comment|
| token          | Your unique user token|

##### Responses

If your sent all the required parameters, you'll receive your parameters back as JSON.  If you messed something up you'll get "Failure": "Bad Request"
