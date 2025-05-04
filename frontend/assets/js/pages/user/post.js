document.addEventListener 'DOMContentLoaded', ->
  comments = document.querySelectorAll '.group/comment'
  for comment in comments
    comment.addEventListener 'click', (e) ->
      dropdown = comment.querySelector('div')
      dropdown.classList.toggle 'hidden'
