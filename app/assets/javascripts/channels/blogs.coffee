jQuery(document).on 'turboliinks:load', ->
  comments = $('#comments')
  if comments.length > 0 
    App.globabl_chat = Appl.cable.subscriptions.create {
     channel:"BlogsChannel"
     blog_id: comments.date('blog-id')
    },
    connected: -> 
    disconnected: ->
    received: (data) ->
      comments.append data['comment']
    send_comment:(comment, blog_id) ->
      @perform 'send_comment', comment: comment, blog_id: blog_id
  $('#new_comment').submit (e) ->
    $this = $(this)
    textarea = $this.find('#comment_content')
    if $.trim(textarea.val()).length > 1
      App.globabl_chat.send_comment textarea.val(),
      comments.data('blog-id')
      textarea.val('')
    e.preventDefault()
    return false