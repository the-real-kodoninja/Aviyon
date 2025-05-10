document.addEventListener 'DOMContentLoaded', ->
  # Tooltip Initialization
  tooltips = document.querySelectorAll '[data-tooltip]'
  tooltips.forEach (tooltip) ->
    tooltip.addEventListener 'mouseenter', ->
      tooltipText = document.createElement 'span'
      tooltipText.className = 'tooltip-text bg-gray-800 text-white p-2 rounded-lg text-xs absolute z-10'
      tooltipText.textContent = tooltip.getAttribute 'data-tooltip'
      tooltip.appendChild tooltipText
      rect = tooltip.getBoundingClientRect()
      tooltipText.style.top = "#{rect.bottom + 5}px"
      tooltipText.style.left = "#{rect.left}px"
    tooltip.addEventListener 'mouseleave', ->
      tooltipText = tooltip.querySelector '.tooltip-text'
      tooltipText?.remove() if tooltipText

  # Comment Toggle
  document.querySelectorAll('.comment-btn').forEach (button) ->
    button.addEventListener 'click', ->
      commentSection = document.querySelector ".comment-section[data-comment-id=\"#{button.getAttribute 'data-comment-id'}\"]"
      commentSection.classList.toggle 'hidden'

  # Emoji, GIF, Photo Upload
  document.querySelectorAll('.add-emoji-btn').forEach (button) ->
    button.addEventListener 'click', ->
      # Placeholder for emoji picker (e.g., integrate emoji-mart)
      alert 'Emoji picker to be implemented'

  document.querySelectorAll('.add-gif-btn').forEach (button) ->
    button.addEventListener 'click', ->
      # Placeholder for GIF integration (e.g., GIPHY API)
      alert 'GIF picker to be implemented'

  document.querySelectorAll('.add-photo-btn').forEach (button) ->
    button.addEventListener 'click', ->
      input = document.createElement 'input'
      input.type = 'file'
      input.accept = 'image/*'
      input.onchange = (e) ->
        file = e.target.files[0]
        if file
          reader = new FileReader()
          reader.onload = (event) ->
            img = document.createElement 'img'
            img.src = event.target.result
            img.className = 'w-32 h-32 rounded-lg mt-2'
            button.parentElement.appendChild img
          reader.readAsDataURL file
      input.click()

  # Comment Submission
  document.querySelectorAll('.submit-comment-btn').forEach (button) ->
    button.addEventListener 'click', ->
      input = button.parentElement.previousElementSibling.querySelector '.comment-input'
      if input.value.trim()
        commentDiv = document.createElement 'div'
        commentDiv.className = 'bg-gray-600 p-3 rounded-lg mt-2'
        commentDiv.innerHTML = "<p class='text-gray-200'>#{input.value}</p>"
        button.parentElement.nextElementSibling.appendChild commentDiv
        input.value = ''

  # Reply Toggle
  document.querySelectorAll('.reply-btn').forEach (button) ->
    button.addEventListener 'click', ->
      replySection = button.nextElementSibling
      replySection.classList.toggle 'hidden'

  # Reply Submission
  document.querySelectorAll('.submit-reply-btn').forEach (button) ->
    button.addEventListener 'click', ->
      input = button.previousElementSibling
      if input.value.trim()
        replyDiv = document.createElement 'div'
        replyDiv.className = 'bg-gray-500 p-2 rounded-lg ml-8 mt-2'
        replyDiv.innerHTML = "<p class='text-gray-100'>#{input.value}</p>"
        button.parentElement.parentElement.appendChild replyDiv
        input.value = ''
        button.parentElement.classList.add 'hidden'
